require 'netscaler/netscaler_service'

module Netscaler
  class Server < NetscalerService
    def initialize(netscaler)
      @netscaler = netscaler
    end

    def add_server(server)
      raise ArgumentError, 'server cannot be null' if server.nil?
      server = Netscaler.hash_hack(server)
      if server[:ipaddress] != nil then
        validate_payload(server, [:name, :ipaddress])
      else
        validate_payload(server, [:name, :domain])
      end

      return @netscaler.adapter.post_no_body('config/server/', {'server' => server})
    end
  end
end
