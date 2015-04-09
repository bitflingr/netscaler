require 'netscaler/ssl/vserver'
require 'netscaler/ssl/vserver/bind'
require 'netscaler/ssl/vserver/unbind'

module Netscaler
  class Ssl

    def initialize(netscaler)
      @netscaler = netscaler
    end

    def vserver
      Vserver.new @netscaler
    end

  end
end
