module TheTradeDeskAds
  # Ad ad creative has many ad images and belongs to an ad account.
  # https://developers.facebook.com/docs/marketing-api/reference/ad-creative
  class AdCreative < Base
    FIELDS = %w[
      AdvertiserId,
      CreativeId,
      CreativeName,
      Description,
      CreativeType,
      ImageAttributes,
      FacebookAttributes,
      FacebookPagePostAttributes,
      FlashAttributes,
      ThirdPartyTagAttributes,
      TradeDeskHostedVideoAttributes,
      ThirdPartyHostedVideoAttributes,
      Html5Attributes,
      HostedNativeAttributes,
      CreativeAuditStatuses,
      FlightStartDateUTC,
      FlightEndDateUTC,
      Availability,
      CreatedAtUTC,
      LastUpdatedAtUTC
    ].freeze
    CALL_TO_ACTION_TYPES = %w[SHOP_NOW INSTALL_MOBILE_APP USE_MOBILE_APP SIGN_UP DOWNLOAD BUY_NOW].freeze

    class << self

    end
  end
end
