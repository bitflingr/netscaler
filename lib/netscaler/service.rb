require 'netscaler/netscaler_service'

module Netscaler
  ##
  # Netscaler::Service handles all service entity calls.
  # This includes #add, #enable, #disable and #show
  class Service < NetscalerService
    def initialize(netscaler)
      @netscaler=netscaler
    end

    ##
    # This method require you already have a server created using Netscaler::Server#add
    # or if it is already configured on the netscaler.
    def add(payload)  # :args: :name, :serverName, :serviceType, :port
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, [:name, :serverName, :serviceType, :port])
      return @netscaler.adapter.post_no_body('config/service/', {'service' => payload})
    end

    def remove(payload) # :args: :server
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, [:name])
      return @netscaler.adapter.delete("config/service/#{payload[:name]}")
    end

    ##
    # :serverName is optional, if omitted it will return all services
    # configured on the Netscaler.
    def show(payload={}) # :args:  :serverName => 'foo'
      if payload[:serviceName] != nil then
        validate_payload(payload, [:serviceName])
        return @netscaler.adapter.get("config/service/#{payload[:serviceName]}")
      elsif payload == {} then
        return @netscaler.adapter.get('config/service/')
      else
        raise ArgumentError, 'payload supplied must have been missing :serviceName'
      end
    end

    def enable(payload) # :args:  :name => 'foo'
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, [:name])
      return @netscaler.adapter.post_no_body('config/service/', {'params' => {'action' => 'enable'}, 'service' => payload})
    end

    def disable(payload) # :args:  :name => 'foo'
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, [:name])
      return @netscaler.adapter.post_no_body('config/service/', {'params' => {'action' => 'disable'}, 'service' => payload})
    end

  end
end
