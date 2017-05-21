require 'coveralls'
Coveralls.wear!

require 'awesome_print'
require 'the_trade_desk_ads'

Dir[File.expand_path(File.join(File.dirname(__FILE__), 'support', '**', '*.rb'))].each { |f| require f }
