# -*- encoding: utf-8 -*-

# To publish the next version:
# gem build the_trade_desk_ads.gemspec
# gem push the_trade_desk_ads-0.1.12.gem
Gem::Specification.new do |s|
  s.name        = 'the_trade_desk_ads'
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ['MIT']
  s.authors     = ['Alan McCann', ]
  s.email       = 'alan@0ptimus.com'
  s.homepage    = 'https://github.com/B30ptimus/the-trade-desk-ruby-ads-sdk'
  s.summary     = 'The Trade Desk Advertising API SDK for Ruby.'
  s.description = "This gem allows to easily manage your TheTradeDesk ads via TheTradeDesk's Advertising API in ruby."

  s.extra_rdoc_files = ['README.md']

  s.required_ruby_version = '~> 2.0'

  s.add_dependency 'rest-client', '>= 1.6'
  s.add_dependency 'hashie', '~> 3.4'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']
end
