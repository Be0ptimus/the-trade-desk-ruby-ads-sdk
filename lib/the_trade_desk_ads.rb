# External requires.
require 'json'
require 'rest-client'
require 'hashie'
require 'logger'

# Internal requires.
require 'the_trade_desk_ads/base'
Dir[File.expand_path('../the_trade_desk_ads/*.rb', __FILE__)].each { |f| require f }

# The primary namespace for this gem.
module TheTradeDeskAds
  def self.logger=(logger)
    @logger = logger
  end

  def self.logger
    unless defined?(@logger)
      @logger       = Logger.new('/dev/null')
      @logger.level = Logger::Severity::UNKNOWN
    end

    @logger
  end

  def self.base_uri=(base_uri)
    @base_uri = base_uri
  end

  # Note: This is the sandbox base uri
  def self.base_uri
    if defined?(@base_uri)
      @base_uri = @base_uri
    elsif @sandbox
      @base_uri = 'https://apisb.thetradedesk.com/v3/'
    else
      @base_uri = 'https://api.thetradedesk.com/v3/'
    end
    @base_uri
  end

  def self.access_token=(access_token)
    @access_token = access_token
  end

  def self.access_token
    @access_token
  end

  def self.login=(login)
    @login = login
  end

  def self.login
    @login
  end

  def self.password=(password)
    @password = password
  end

  def self.password
    @password
  end

  def self.alan=(alan)
    @alan = alan
  end

  def self.alan
    @alan
  end


  def self.sandbox=(sandbox)
    @sandbox = sandbox
  end

  def self.sandbox
    @sandbox
  end

  def self.token_expiration_in_minutes=(token_expiration_in_minutes)
    @token_expiration_in_minutes = token_expiration_in_minutes
  end

  def self.token_expiration_in_minutes
    @token_expiration_in_minutes || 60
  end

end
