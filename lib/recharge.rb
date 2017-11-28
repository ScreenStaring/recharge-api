require "recharge/classes"
require "recharge/version"

module Recharge
  ENDPOINT = "api.rechargeapps.com".freeze
  PORT = 443
  TOKEN_HEADER = "X-Recharge-Access-Token".freeze
  USER_AGENT = "ReCharge API Client v#{VERSION} (Ruby v#{RUBY_VERSION})"

  Error = Class.new(StandardError)
  ConnectionError = Class.new(Error)

  #
  # Raised when a non-2XX HTTP response is returned
  #
  class RequestError < Error
    attr_accessor :errors
    attr_accessor :status
    attr_accessor :meta

    def initialize(message, status, meta = nil, errors = nil)
      super message
      @status = status
      @meta = meta || {}
      @errors = errors || {}
    end
  end

  class << self
    attr_accessor :api_key
    # If +true+ output HTTP request/response to stderr. Can also be an +IO+ instance to output to.
    attr_accessor :debug
  end
end

ReCharge = Recharge
