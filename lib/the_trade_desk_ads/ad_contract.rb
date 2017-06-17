module TheTradeDeskAds
  class AdContract < Base

    FIELDS = %w[
      ContractId
      OwnerPartnerId
      Name
      Description
      StartDateUTC
      EndDateUTC
      CurrencyCode
      Deals
      Permissions
      Availability
      DeliveryPriorities
      ContractType
      ApprovalState
    ].freeze

    class << self
    end

  end
end
