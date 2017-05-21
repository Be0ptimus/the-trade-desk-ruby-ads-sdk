[![Gem Version](https://badge.fury.io/rb/the_trade_desk_ads.svg)](https://badge.fury.io/rb/facebook_ads)
[![Build Status](https://travis-ci.org/Be0ptimus/the-trade-desk-ruby-ads-sdk.svg?branch=master)](https://travis-ci.org/Be0ptimus/the-trade-desk-ruby-ads-sdk)
[![Coverage Status](https://coveralls.io/repos/github/Be0ptimus/the-trade-desk-ruby-ads-sdk/badge.svg?branch=master)](https://coveralls.io/github/Be0ptimus/the-trade-desk-ruby-ads-sdk?branch=master)

# [TheTradeDesk Marketing API](https://apisb.thetradedesk.com/v3/doc) SDK for Ruby

![Facebook Ads](https://www.thetradedesk.com/img/the-trade-desk.svg)

This gem allows you to manage your TheTradeDesk Ads using a ruby interface. It allows you to list, create, update and destroy TheTradeDesk Ad objects (advertisers, campaigns, ad groups, etc) and get reports about the performance of TheTradeDesk Ads.


## Still in early development - DO NOT USE

## Install

```bash
gem install the_trade_desk_ads
```

Or, add the following to your Gemfile:

```ruby
gem 'the_trade_desk_ads', '~> 0.1'
```


## Ruby Version

Requires Ruby >= 2.0


## Permissions

You'll need a Login and a Password in order to use TheTradeDesk's Advertising API.

```ruby
TheTradeDeskAds.login = '[YOUR_LOGIN]'
TheTradeDeskAds.password = '[YOUR_PASSWORD]'
```

## API Version

This gem currently uses v3 of the Advertising API. You can change the version as desired with the following:

```ruby
TheTradeDeskAds.base_uri = 'https://apisb.thetradedesk.com/v3/'
```

## Console

This gem provides a console using [Pry](https://github.com/pry/pry) and [AwesomePrint](https://github.com/awesome-print/awesome_print) for you to test & debug.
It reads the Login and Password from files called test_login and test_password.

```bash
echo [YOUR_LOGIN] > test_login
echo [YOUR_PASSWORD] > test_password
bin/console
```


## @TODO:

* Everything
