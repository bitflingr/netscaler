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

    def add_service(payload)
      self.add(payload)
    end

    def show(payload)
      return @netscaler.adapter.get('config/service/', args) if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:serviceName])
      return @netscaler.adapter.get("config/service/#{payload[:serviceName]}")
    end

    def get_service(payload)
      self.show(payload)
    end

    def get_services(args={})
      return @netscaler.adapter.get('config/service/', args)
    end

    def enable(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:name])
      return @netscaler.adapter.post_no_body('config/service/', {'params' => {'action' => 'enable'}, 'service' => payload})
    end

    def enable_service(payload)
      self.enable(payload)
    end

    def disable(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:name])
      return @netscaler.adapter.post_no_body('config/service/', {'params' => {'action' => 'disable'}, 'service' => payload})
    end

    def disable_service(payload)
      self.disable(payload)
    end

    def lbmonitor_service_binding(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:serviceName, :monitorName])
      return @netscaler.adapter.post_no_body("config/lbmonitor_service_binding/#{payload[:monitorName]}?action=bind", {'params' => {'action' => 'bind'}, 'lbmonitor_service_binding' => payload})
    end

    def lbmonitor_service_unbinding(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:serviceName, :monitorName])
      return @netscaler.adapter.post_no_body("config/lbmonitor_service_binding/#{payload[:monitorName]}?action=unbind", {'params' => {'action' => 'unbind'}, 'lbmonitor_service_binding' => payload})
    end

  end
end
