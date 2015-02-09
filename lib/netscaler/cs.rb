require 'netscaler/cs/policy'
require 'netscaler/cs/vserver'
require 'netscaler/cs/vserver/bind'
require 'netscaler/cs/vserver/unbind'

module Netscaler
  class Cs

    def initialize(netscaler)
      @netscaler = netscaler
    end

    def vserver
      Vserver.new @netscaler
    end

    def policy
      Policy.new @netscaler
    end

  end
end