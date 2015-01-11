require 'netscaler/rewrite/action'
require 'netscaler/rewrite/policy'

module Netscaler
  class Rewrite

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