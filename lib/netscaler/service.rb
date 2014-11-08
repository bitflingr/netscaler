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
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:name, :serverName, :serviceType, :port])
      return @netscaler.adapter.post_no_body('config/service/', {'service' => payload})
    end

    ##
    # :category: Deprecated Methods
    # DEPRECATED: Please use #add instead=.
    def add_service(payload)
      warn '[DEPRECATION] "add_service" is deprecated.  Please use "#add" instead.'
      self.add(payload)
    end

    ##
    # :serverName is optional, if omitted it will return all services
    # configured on the Netscaler.
    def show(payload={}) # :args:  :serverName => 'foo'
      if payload[:serviceName] != nil then
        payload = Netscaler.hash_hack(payload)
        validate_payload(payload, [:serviceName])
        return @netscaler.adapter.get("config/service/#{payload[:serviceName]}")
      elsif payload == {} then
        return @netscaler.adapter.get('config/service/')
      else
        raise ArgumentError, 'payload supplied must have been missing :serviceName'
      end
    end

    ##
    # :category: Deprecated Methods
    # DEPRECATED: Please use #show instead=.
    def get_service(payload)
      warn '[DEPRECATION] "get_service" is deprecated.  Please use "#show" instead.'
      self.show(payload)
    end

    ##
    # :category: Deprecated Methods
    # DEPRECATED: Please use #show instead=.
    def get_services(args={})
      warn '[DEPRECATION] "get_services" is deprecated.  Please use "#show" instead.'
      return @netscaler.adapter.get('config/service/', args)
    end

    def enable(payload) # :args:  :name => 'foo'
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:name])
      return @netscaler.adapter.post_no_body('config/service/', {'params' => {'action' => 'enable'}, 'service' => payload})
    end

    ##
    # :category: Deprecated Methods
    # DEPRECATED: Please use #enable instead=.
    def enable_service(payload)
      warn '[DEPRECATION] "enable_service" is deprecated.  Please use "#enable" instead.'
      self.enable(payload)
    end

    def disable(payload) # :args:  :name => 'foo'
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:name])
      return @netscaler.adapter.post_no_body('config/service/', {'params' => {'action' => 'disable'}, 'service' => payload})
    end

    ##
    # :category: Deprecated Methods
    # DEPRECATED: Please use #disable instead=.
    def disable_service(payload)
      warn '[DEPRECATION] "disable_service" is deprecated.  Please use "#disable" instead.'
      self.disable(payload)
    end

    ##
    # :category: Deprecated Methods
    # DEPRECATED: Please use Netscaler::Lb::Monitor.bind instead=.
    def lbmonitor_service_binding(payload)
      warn '[DEPRECATION] "lbmonitor_service_binding" is deprecated.  Please use "Netscaler::Lb::Monitor.bind" instead.'
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:serviceName, :monitorName])
      return @netscaler.adapter.post_no_body("config/lbmonitor_service_binding/#{payload[:monitorName]}?action=bind", {'params' => {'action' => 'bind'}, 'lbmonitor_service_binding' => payload})
    end

    ##
    # :category: Deprecated Methods
    # DEPRECATED: Please use Netscaler::Lb::Monitor.unbind instead=.
    def lbmonitor_service_unbinding(payload)
      warn '[DEPRECATION] "lbmonitor_service_binding" is deprecated.  Please use "Netscaler::Lb::Monitor.bind" instead.'
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:serviceName, :monitorName])
      return @netscaler.adapter.post_no_body("config/lbmonitor_service_binding/#{payload[:monitorName]}?action=unbind", {'params' => {'action' => 'unbind'}, 'lbmonitor_service_binding' => payload})
    end

  end
end
