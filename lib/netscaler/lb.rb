require 'netscaler/lb/monitor'
require 'netscaler/lb/vserver'
require 'netscaler/lb/vserver/bind'
require 'netscaler/lb/vserver/unbind'

module Netscaler
  class Lb

    def initialize(netscaler)
      @netscaler = netscaler
    end

    def monitor
      Monitor.new @netscaler
    end

    def vserver
      Vserver.new @netscaler
    end

  end
end