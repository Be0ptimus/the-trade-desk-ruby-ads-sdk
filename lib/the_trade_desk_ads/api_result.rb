module TheTradeDeskAds
  class ApiResult

    attr_accessor :results, :result_count, :total_filtered_count, :total_unfiltered_count

    def initialize( results: results,
                    result_count: result_count,
                    total_filtered_count: total_filtered_count,
                    total_unfiltered_count: total_unfiltered_count)
      @results = results || {}
      @result_count = result_count || 0
      @total_filtered_count = total_filtered_count || 0
      @total_unfiltered_count = total_unfiltered_count || 0
    end
  end
end
