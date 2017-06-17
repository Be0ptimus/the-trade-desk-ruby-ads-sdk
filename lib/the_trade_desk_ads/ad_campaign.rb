module TheTradeDeskAds
  # An ad campaign belongs to an advertiser

  class AdCampaign < Base
    FIELDS = %w[
      AdvertiserId
      CampaignId
      CampaignName
      Description
      Budget
      BudgetInImpressions
      DailyBudget
      DailyBudgetInImpressions
      StartDate
      EndDate
      PartnerCostPercentageFee
      PartnerCPMFee
      CampaignConversionReportingColumns
      Availability
      AutoAllocatorEnabled
      PacingMode
      CampaignFlights
      CreatedAtUTC
      LastUpdatedAtUTC
    ].freeze

    AVAILABILITIES = %w[Available Archived].freeze
    PACING_MODES = %w[On Off]
    SORTING_FIELDS = { 'Name': 'Name',
                       'Description': 'Description' }.freeze

    # belongs_to ad_advertiser

    def ad_advertiser
      @ad_advertiser ||= AdAdvertiser.find(self.AdvertiserId)
    end

    # belongs_to ad_campaign

    def ad_campaign
      @ad_campaign ||= AdCampaign.find(self.CampaignId)
    end


    # has_many ad_campaign_flights

    def ad_campaign_flights
      self.CampaignFlights.map{|flight| TheTradeDeskAds::Base.instantiate(AdCampaignFlight, flight)}
    end

 
  end
end
