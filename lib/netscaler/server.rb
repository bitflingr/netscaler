require 'netscaler/netscaler_service'

module Netscaler
  class Server < NetscalerService
    def initialize(netscaler)
      @netscaler = netscaler
    end

    ##
    # method #add requires arg :name but :ipaddress and :domain are optional but requires one of them.
    def add(server) # :args: :name => 'foo', :ipaddress => '192.168.1.10', :domain => 'bar.com'
      raise ArgumentError, 'server cannot be null' if server.nil?
      server = Netscaler.hash_hack(server)
      if server[:domain] != nil then
        validate_payload(server, [:name, :domain])
      else
        validate_payload(server, [:name, :ipaddress])
      end

      return @netscaler.adapter.post_no_body('config/server/', {'server' => server})
    end

    def remove(payload) # :args: :server
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:server])
      return @netscaler.adapter.delete("config/server/#{payload[:server]}")
    end

    ##
    # :category: Deprecated Methods
    # DEPRECATED: Please use #add instead=.
    def add_server(server)
      warn '[DEPRECATION] "add_server" is deprecated.  Please use "#add" instead.'
      self.add server
    end
  end
end
