require 'netscaler/netscaler_service'

module Netscaler
  class Service < NetscalerService
    def initialize(netscaler)
      @netscaler=netscaler
    end

    def add(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:name, :serverName, :serviceType, :port])
      return @netscaler.adapter.post_no_body('config/service/', {'service' => payload})
    end

    # DEPRECATED: Please use #add instead=.
    def add_service(payload)
      warn '[DEPRECATION] "add_service" is deprecated.  Please use "#add" instead.'
      self.add(payload)
    end

    def show(payload)
      return @netscaler.adapter.get('config/service/', args) if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:serviceName])
      return @netscaler.adapter.get("config/service/#{payload[:serviceName]}")
    end

    # DEPRECATED: Please use #show instead=.
    def get_service(payload)
      warn '[DEPRECATION] "get_service" is deprecated.  Please use "#show" instead.'
      self.show(payload)
    end

    # DEPRECATED: Please use #show instead=.
    def get_services(args={})
      warn '[DEPRECATION] "get_services" is deprecated.  Please use "#show" instead.'
      return @netscaler.adapter.get('config/service/', args)
    end

    def enable(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:name])
      return @netscaler.adapter.post_no_body('config/service/', {'params' => {'action' => 'enable'}, 'service' => payload})
    end

    # DEPRECATED: Please use #enable instead=.
    def enable_service(payload)
      warn '[DEPRECATION] "enable_service" is deprecated.  Please use "#enable" instead.'
      self.enable(payload)
    end

    def disable(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:name])
      return @netscaler.adapter.post_no_body('config/service/', {'params' => {'action' => 'disable'}, 'service' => payload})
    end

    # DEPRECATED: Please use #disable instead=.
    def disable_service(payload)
      warn '[DEPRECATION] "disable_service" is deprecated.  Please use "#disable" instead.'
      self.disable(payload)
    end

    # DEPRECATED: Please use Netscaler::Lb::Monitor.bind instead=.
    def lbmonitor_service_binding(payload)
      warn '[DEPRECATION] "lbmonitor_service_binding" is deprecated.  Please use "Netscaler::Lb::Monitor.bind" instead.'
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:serviceName, :monitorName])
      return @netscaler.adapter.post_no_body("config/lbmonitor_service_binding/#{payload[:monitorName]}?action=bind", {'params' => {'action' => 'bind'}, 'lbmonitor_service_binding' => payload})
    end

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
