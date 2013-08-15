require 'netscaler/netscaler_service'

module Netscaler
  class Service < NetscalerService
    def initialize(netscaler)
      @netscaler=netscaler
    end

    def add_service(payload)
      return @netscaler.adapter.post_no_body('config/service/', {'service' => payload})
    end

    def get_service(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, %w(serviceName))
      return @netscaler.adapter.get("config/service/#{payload[:serviceName]}")
    end

    def get_services(args={})
      return @netscaler.adapter.get("config/service/", args)
    end

    def lbmonitor_service_binding(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, %w(serviceName monitorName))
      return @netscaler.adapter.post_no_body("config/lbmonitor_service_binding/#{payload['monitorName']}?action=bind", "lbmonitor_service_binding" => payload)
    end

    def lbmonitor_service_unbinding(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, %w(serviceName monitorName))
      return @netscaler.adapter.post_no_body("config/lbmonitor_service_binding/#{payload['monitorName']}?action=unbind", "lbmonitor_service_unbinding" => payload)
    end

  end
end
