module TheTradeDeskAds
  # The base class for all ads objects.
  class Base < Hashie::Mash
    class << self
      def auth(login: TheTradeDeskAds.login, password: TheTradeDeskAds.password, token_expiration_in_minutes: TheTradeDeskAds.token_expiration_in_minutes)
        query = { "Login": login,
                  "Password": password }
        if token_expiration_in_minutes && token_expiration_in_minutes.integer?
           query['TokenExpirationInMinutes'] = token_expiration_in_minutes
        end
        uri = "#{TheTradeDeskAds.base_uri}authentication"
        TheTradeDeskAds.logger.debug "POST #{uri}"
        response = begin
          RestClient.post(uri, query.to_json, content_type: :json)
        rescue RestClient::Exception => e
          exception(:post, uri, e)
        end
        TheTradeDeskAds.access_token = JSON.parse(response)['Token'] unless e
      end

      def find(id)
        uri = "#{to_s.gsub('TheTradeDeskAds::Ad', '').downcase}/#{id}"
        get(uri, objectify: true)
      end

      def get(path, query: {}, objectify:)
        # query = pack(query, objectify: objectify) # Adds access token, fields, etc.
        uri = "#{TheTradeDeskAds.base_uri}#{path}?" + build_nested_query(query)
        TheTradeDeskAds.logger.debug "GET #{uri}"
        response = begin
          RestClient.get(uri, "TTD-Auth": TheTradeDeskAds.access_token)
        rescue RestClient::Exception => e
          exception(:get, path, e)
        end
        unpack(response, objectify: objectify)
      end

      def post(path, query: {}, objectify:)
        # query = pack(query, objectify: objectify)
        uri = "#{TheTradeDeskAds.base_uri}#{path}"
        TheTradeDeskAds.logger.debug "POST #{uri} #{query}"
        response = begin
          RestClient.post(uri, query.to_json, "TTD-Auth": TheTradeDeskAds.access_token, content_type: :json)
        rescue RestClient::Exception => e
          exception(:post, path, e)
        end
        unpack(response, objectify: objectify)
      end

      def delete(path, query: {})
        query = pack(query, objectify: false)
        uri = "#{TheTradeDeskAds.base_uri}#{path}?" + build_nested_query(query)
        TheTradeDeskAds.logger.debug "DELETE #{uri}"
        response = begin
          RestClient.delete(uri)
        rescue RestClient::Exception => e
          exception(:delete, path, e)
        end
        unpack(response, objectify: false)
      end

      def paginate(path, query: {})
        query[:limit] ||= 100
        limit = query[:limit]
        response = get(path, query: query.merge(fields: self::FIELDS.join(',')), objectify: false)
        data = response['data'].nil? ? [] : response['data']

        if data.length == limit
          while !(paging = response['paging']).nil? && !(url = paging['next']).nil?
            TheTradeDeskAds.logger.debug "GET #{url}"
            response = begin
              RestClient.get(url)
            rescue RestClient::Exception => e
              exception(:get, url, e)
            end
            response = unpack(response, objectify: false)
            data += response['data'] unless response['data'].nil?
          end
        end

        if data.nil?
          []
        else
          data.map { |hash| instantiate(hash) }
        end
      end

      private

      def instantiate(hash)
        object = new
        hash.each_pair do |key, value|
          # https://github.com/intridea/hashie/blob/master/lib/hashie/mash.rb#L111
          # key = '_hash' if key == 'hash'
          if key == 'Children' && !value.empty?
            children = []
            value.each do |child|
              children << instantiate(child)
            end
            object.custom_writer(key, children, false)
          else
            object.custom_writer(key, value, false)
          end
        end

        object
      end

      def pack(hash, objectify:)
        # hash = hash.merge(access_token: TheTradeDeskAds.access_token)
        hash = hash.merge(fields: self::FIELDS.join(',')) if objectify
        hash.delete_if { |_k, v| v.nil? }
        hash
      end

      def unpack(response, objectify:)
        raise Exception, 'Invalid nil response' if response.nil?
        response = response.body if response.is_a?(RestClient::Response)

        if response.is_a?(String)
          response = begin
            JSON.parse(response)
          rescue JSON::ParserError
            raise Exception, "Invalid JSON response: #{response.inspect}"
          end
        end

        raise Exception, "Invalid response: #{response.class.name} #{response.inspect}" unless response.is_a?(Hash)
        raise Exception, "[#{response['error']['code']}] #{response['error']['message']} - raw response: #{response.inspect}" unless response['error'].nil?
        return response unless objectify

        if response.key?('Result') && (data = response['Result']).is_a?(Array)
          data.map { |hash| instantiate(hash) }
          results = []
          data.each do |datum|
            results << instantiate(datum)
          end
          results = ApiResult.new(results: response['Result'],
                                  result_count: response['ResultCount'],
                                  total_filtered_count: response['TotalFilteredCount'],
                                  total_unfiltered_count: response['TotalUnfilteredCount'])
        else
          results = instantiate(response)
        end
        results
      end

      def escape(s)
        URI.encode_www_form_component(s)
      end

      # https://github.com/rack/rack/blob/master/lib/rack/utils.rb
      def build_nested_query(value, prefix = nil)
        case value
        when Array
          value.map { |v| build_nested_query(v, "#{prefix}[]") }.join('&')
        when Hash
          value.map { |k, v| build_nested_query(v, prefix ? "#{prefix}[#{escape(k)}]" : escape(k)) }.reject(&:empty?).join('&')
        when nil
          prefix
        else
          raise ArgumentError, 'value must be a Hash' if prefix.nil?
          "#{prefix}=#{escape(value)}"
        end
      end

      def exception(verb, path, exception)
        TheTradeDeskAds.logger.error exception.response
        response = exception.response

        message = if response.is_a?(String)
          begin
            if (error = JSON.parse(response)['error']).nil?
              response
            elsif error['error_subcode'].nil? || error['error_user_title'].nil? || error['error_user_msg'].nil?
              "#{error['type']} / #{error['code']}: #{error['message']}"
            else
              exception = AdException.new(
                code: error['error_subcode'],
                title: error['error_user_title'],
                message: error['error_user_msg']
              )
              "#{exception.code} / #{exception.title}: #{exception.message}"
            end
          rescue JSON::ParserError
            response
          end
        else
          response.inspect
        end

        TheTradeDeskAds.logger.error "#{verb.upcase} #{path} #{message}"
        raise exception
      end
    end

    def save
      return nil if changes.nil? || changes.length.zero?
      data = {}
      changes.keys.each { |key| data[key] = self[key] }
      return nil unless update(data)
      self.class.find(id)
    end

    def update(data)
      return false if data.nil?
      response = self.class.post("/#{id}", query: data)
      response['success']
    end

    def destroy(path: nil, query: {})
      response = self.class.delete(path || "/#{id}", query: query)
      response['success']
    end

    protected

    attr_accessor :changes

    def persisted?
      !id.nil?
    end

    private

    def []=(key, value)
      old_value = self[key]
      new_value = super(key, value)

      self.changes ||= {}

      if old_value != new_value
        self.changes[key] = [old_value, new_value]
      else
        self.changes.delete(key)
      end

      new_values
    end
  end
end
