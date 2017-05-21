module TheTradeDeskAds
  # An ad belongs to an ad set. It is created using an ad creative.
  # https://developers.facebook.com/docs/marketing-api/reference/adgroup
  class AdFormat < Base
    FIELDS = %w[AdFormatId AdFormatName Width Height IsDisplayRTBEligible IsFacebookRightHandSideEligible IsFacebookPagePostEligible].freeze

    # Sorting Formats: name, display name
    SORTING_FIELDS = { "Name": 'Name' }.freeze

    class << self
      def facets(query = {})
        get('adformat/query/facets', query: query, objectify: false)
      end

      def all(sort_fields: nil, page_start_index: 0, page_size: nil)
        query = { "SortFields": sort_fields,
                  "PageStartIndex": page_start_index,
                  "PageSize": page_size }
        # query.delete_if { |_k, v| v.nil? }
        post('adformat/query', query: query, objectify: true)
      end

      # Search term example
      # ad_formats = TheTradeDeskAds::AdFormat.search(search_terms: ["banner"])
      # Sorting example
      # ad_formats = TheTradeDeskAds::AdFormat.search(sort_fields: [{"FieldId": "Name","Ascending": true}])

      def search(search_terms: nil, sort_fields: nil, page_start_index: 0, page_size: 10)
        query = { "SearchTerms": search_terms,
                  "SortFields": sort_fields,
                  "PageStartIndex": page_start_index,
                  "PageSize": page_size }
        query.delete_if { |_k, v| v.nil? }
        post('adformat/query', query: query, objectify: true)
      end
    end
  end
end
