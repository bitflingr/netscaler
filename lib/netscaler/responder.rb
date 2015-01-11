require 'netscaler/responder/action'
require 'netscaler/responder/policy'

module Netscaler
  class Responder

    def initialize(netscaler)
      @netscaler = netscaler
    end

    def action
      Action.new @netscaler
    end

    def policy
      Policy.new @netscaler
    end

  end
end