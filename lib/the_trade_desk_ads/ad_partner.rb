module TheTradeDeskAds
  # An ad belongs to an ad set. It is created using an ad creative.
  # https://developers.facebook.com/docs/marketing-api/reference/adgroup
  class AdPartner < Base
    FIELDS = %w[PartnerId].freeze
    # Sorting Formats: name, display name
    SORTING_FIELDS = { "Name": 'Name' }.freeze

    # facets = TheTradeDeskAds::AdPartner.facets

    class << self
      def facets(query = {})
        get('partner/query/facets', query: query, objectify: false)
      end

      # Not implemented in API
      def find(_id)
        raise Exception, 'Not implemented in TheTradeDesk API'
      end
    end

    # has_many advertisers
    # partner = TheTradeDeskAds::AdPartner.new(PartnerId: {partner_id})
    # partner_advertisers = partner.advertisers

    def ad_advertisers(availabilities: %w(Available Archived), search_terms: nil, sort_fields: nil, page_start_index: 0, page_size: 10)
      raise Exception, 'Partner ID must be specified' unless self.PartnerId
      raise Exception, "Availabilities must be one of: #{TheTradeDeskAds::AdAdvertiser::AVAILABILITIES.join(', ')}" unless (availabilities - TheTradeDeskAds::AdAdvertiser::AVAILABILITIES).empty?
      query = { "PartnerId": self.PartnerId,
                "Availabilities": availabilities,
                "SearchTerms": search_terms,
                "SortFields": sort_fields,
                "PageStartIndex": page_start_index,
                "PageSize": page_size }
      query.delete_if { |_k, v| v.nil? }
      AdPartner.post('advertiser/query/partner', query: query, objectify: TheTradeDeskAds::AdAdvertiser )
    end
  end
end
