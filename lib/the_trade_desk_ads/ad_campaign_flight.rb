module TheTradeDeskAds
  # An ad campaign flight belongs to a campaign
  class AdCampaignFlight < Base
    FIELDS = %w[
      CampaignFlightId
      CampaignId
      StartDateInclusiveUTC
      EndDateExclusiveUTC
      BudgetInAdvertiserCurrency
      BudgetInImpressions
      DailyTargetInAdvertiserCurrency
      DailyTargetInImpressions
    ].freeze

    # belongs_to ad_campaign

    def ad_campaign
      @ad_campaign ||= AdCampaign.find(self.CampaignId)
    end

  end
end
