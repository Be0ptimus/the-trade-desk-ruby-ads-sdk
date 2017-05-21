module TheTradeDeskAds
  class ApiResult
    attr_accessor :results, :result_count, :total_filtered_count, :total_unfiltered_count

    def initialize(results: query_results,
                   result_count: query_result_count,
                   total_filtered_count: query_total_filtered_count,
                   total_unfiltered_count: query_total_unfiltered_count)
      @results = results || {}
      @result_count = result_count || 0
      @total_filtered_count = total_filtered_count || 0
      @total_unfiltered_count = total_unfiltered_count || 0
    end
  end
end
