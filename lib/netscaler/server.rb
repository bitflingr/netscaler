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
      if server[:domain] != nil then
        validate_payload(server, [:name, :domain])
      else
        validate_payload(server, [:name, :ipaddress])
      end

      return @netscaler.adapter.post_no_body('config/server/', {'server' => server})
    end

    def remove(payload) # :args: :server
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, [:server])
      return @netscaler.adapter.delete("config/server/#{payload[:server]}")
    end

    def enable(payload) # :args: :server, :service_group
      toggle('enable', payload)
    end

    def disable(payload) # :args: :server, :service_group
      toggle('disable', payload)
    end

    def show_bindings(payload)  # :args:  :server => 'foo'
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, [:server])
      return @netscaler.adapter.get("config/server_binding/#{payload[:server]}")
    end

    ##
    # :server is optional, if omitted it will return all servers
    # configured on the Netscaler.
    def show(payload = {}) # :args:  :server => 'foo'
      if payload[:server] != nil then
        validate_payload(payload, [:server])
        return @netscaler.adapter.get("config/server/#{payload[:server]}")
      elsif payload == {} then
        return @netscaler.adapter.get('config/server/')
      else
        raise ArgumentError, 'payload supplied must have been missing :server'
      end
    end

  private
    def toggle(toggle_action, payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      #validate_payload(payload, [:server, :service_group])
      validate_payload(payload, [:server])
      return @netscaler.adapter.post('config/', {"params" => {"action" => toggle_action}, "server" => {"name" => payload[:server]}})
    end
  end
end
