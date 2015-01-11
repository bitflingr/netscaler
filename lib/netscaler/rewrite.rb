require 'netscaler/rewrite/action'

module Netscaler
  class Rewrite

    def initialize(netscaler)
      @netscaler = netscaler
    end

    def action
      Action.new @netscaler
    end

  end
end