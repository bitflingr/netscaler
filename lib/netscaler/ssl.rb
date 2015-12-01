require 'netscaler/ssl/vserver'
require 'netscaler/ssl/vserver/bind'
require 'netscaler/ssl/vserver/unbind'
require 'netscaler/ssl/certkey'

module Netscaler
  class Ssl

    def initialize(netscaler)
      @netscaler = netscaler
    end

    def vserver
      Vserver.new @netscaler
    end

    def certkey
      Certkey.new @netscaler
    end
  end
end
