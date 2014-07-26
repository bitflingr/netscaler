require 'netscaler/lb/monitor'

module Netscaler
  class Lb

    def initialize(netscaler)
      @netscaler = netscaler
    end

    def monitor
      Monitor.new @netscaler
    end

  end
end