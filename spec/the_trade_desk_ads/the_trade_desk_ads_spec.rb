require 'spec_helper'

# rspec spec/the_trade_desk_ads/the_trade_desk_ads_spec.rb
describe TheTradeDeskAds do
  describe '#base_uri' do
    it 'is currency v2.8' do
      expect(TheTradeDeskAds.base_uri.include?('2.8')).to be_truthy
    end

    it 'can be set to v2.9' do
      TheTradeDeskAds.base_uri = 'https://graph.facebook.com/v2.9'
      expect(TheTradeDeskAds.base_uri.include?('2.9')).to be_truthy
    end
  end
end
