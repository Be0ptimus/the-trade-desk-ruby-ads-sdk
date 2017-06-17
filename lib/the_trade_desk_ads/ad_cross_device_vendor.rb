module TheTradeDeskAds
  class AdCrossDeviceVendor < Base

    FIELDS = %w[
      CrossDeviceVendorId
      CrossDeviceVendorName
      CrossDeviceVendorFee
    ].freeze

    class << self
      # All
      # TheTradeDeskAds::AdCrossDeviceVendor.all(advertiser_id: advertiser.AdvertiserId)
      def all_for_advertiser(advertiser_id: nil, page_start_index: 0, page_size: nil)
        query = { "AdvertiserId": advertiser_id,
                  "PageStartIndex": page_start_index,
                  "PageSize": page_size }
        # query.delete_if { |_k, v| v.nil? }
        post('crossdevicevendor/query/advertiser', query: query, objectify: AdCrossDeviceVendor)
      end
    end
  end
end
