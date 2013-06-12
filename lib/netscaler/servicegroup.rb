require 'netscaler/netscaler_service'

module Netscaler
  class ServiceGroup < NetscalerService
    def initialize(netscaler)
      @netscaler=netscaler
    end

    def add_servicegroup(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, %w(serviceGroupName serviceType))
      return @netscaler.adapter.post_no_body("config/servicegroup/", "servicegroup" => payload)
    end

    def get_servicegroup(payload)
      raise ArgumentError, 'payload must have key serviceGroupName' unless payload.has_key?('serviceGroupName')
      return @netscaler.adapter.get("config/servicegroup/#{payload['serviceGroupName']}")
    end

    def get_servicegroups(args={})
      return @netscaler.adapter.get("config/servicegroup/", args)
    end

    def get_servicegroup_servicegroupmember_bindings(payload)
      return @netscaler.adapter.get("config/servicegroup_servicegroupmember_binding/#{payload}")
    end

    def lbmonitor_servicegroup_binding(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, %w(serviceGroupName monitorName))
      return @netscaler.adapter.post_no_body("config/lbmonitor_servicegroup_binding/#{payload['monitorName']}?action=bind", "lbmonitor_servicegroup_binding" => payload)
    end

    def lbmonitor_servicegroup_unbinding(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, %w(serviceGroupName monitorName))
      return @netscaler.adapter.post_no_body("config/lbmonitor_servicegroup_binding/#{payload['monitorName']}?action=unbind", "lbmonitor_servicegroup_unbinding" => payload)
    end

    def bind_servicegroup_servicegroupmember(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, %w(serviceGroupName port ip))
      return @netscaler.adapter.post_no_body("config/servicegroup_servicegroupmember_binding/#{payload['serviceGroupName']}?action=bind", "servicegroup_servicegroupmember_binding" => payload)
    end

    def unbind_servicegroup_servicegroupmember(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, %w(serviceGroupName port ip))
      return @netscaler.adapter.post_no_body("config/servicegroup_servicegroupmember_binding/#{payload['serviceGroupName']}?action=unbind", "servicegroup_servicegroupmember_binding" => payload)
    end

  end
end
