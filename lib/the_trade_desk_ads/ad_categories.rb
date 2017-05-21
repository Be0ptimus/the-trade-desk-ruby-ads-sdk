module TheTradeDeskAds
  # An ad belongs to an ad set. It is created using an ad creative.
  # https://developers.facebook.com/docs/marketing-api/reference/adgroup
  class AdCategories < Base
    FIELDS   = %w[CategoryId ParentCategoryId Name Path Children].freeze

    class << self
      def all(query = {})
        get('category/industrycategories', query: {}, objectify: true)
      end
    end
  end
end
