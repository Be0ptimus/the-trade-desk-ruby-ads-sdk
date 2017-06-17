module TheTradeDeskAds

  class AdTechnology < Base
    FIELDS = %w[
      AdTechnologyId
      AdTechnologyName
    ].freeze

    # Sorting Technologies: name, display name
    SORTING_FIELDS = { "Name": 'Name' }.freeze

    class << self
      def facets(query = {})
        get('adtechnology/query/facets', query: query, objectify: false)
      end

      # ad_technologies = TheTradeDeskAds::AdTechnology.all
      def all(sort_fields: nil, page_start_index: 0, page_size: nil)
        query = { "SortFields": sort_fields,
                  "PageStartIndex": page_start_index,
                  "PageSize": page_size }
        # query.delete_if { |_k, v| v.nil? }
        post('adtechnology/query', query: query, objectify: AdTechnology)
      end

      # Search term example
      # ad_technologies = TheTradeDeskAds::AdTechnology.search(search_terms: ["Demand"])
      # Sorting example
      # ad_technologies = TheTradeDeskAds::AdTechnology.search(sort_fields: [{"FieldId": "Name","Ascending": true}])

      def search(search_terms: nil, sort_fields: nil, page_start_index: 0, page_size: 10)
        query = { "SearchTerms": search_terms,
                  "SortFields": sort_fields,
                  "PageStartIndex": page_start_index,
                  "PageSize": page_size }
        query.delete_if { |_k, v| v.nil? }
        post('adtechnology/query', query: query, objectify: AdTechnology)
      end
    end
  end
end