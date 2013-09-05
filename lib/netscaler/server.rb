require 'netscaler/netscaler_service'

module Netscaler
  class Server < NetscalerService
    def initialize(netscaler)
      @netscaler = netscaler
    end

    def add_server(server)
      raise ArgumentError, 'server cannot be null' if server.nil?
      validate_payload(server, %w(name ipaddress))
      return @netscaler.adapter.post_no_body('config/server/', {'server' => server})
    end
  end
end
