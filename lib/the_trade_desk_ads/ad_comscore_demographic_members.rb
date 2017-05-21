module TheTradeDeskAds
  # An ad belongs to an ad set. It is created using an ad creative.
  # https://developers.facebook.com/docs/marketing-api/reference/adgroup
  class AdComscoreDemographicMembers < Base
    FIELDS = %w[Id Name ComscoreDemographicMembers].freeze

    class << self
      def all(query = {})
        get('comscore/populationdemographicmembers', query: query, objectify: true)
      end
    end
  end
end
