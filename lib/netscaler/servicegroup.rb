require 'netscaler/netscaler_service'

module Netscaler
  class ServiceGroup < NetscalerService
    def initialize(netscaler)
      @netscaler=netscaler
    end

    def add(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:serviceGroupName, :serviceType])
      return @netscaler.adapter.post_no_body("config/servicegroup/", "servicegroup" => payload)
    end

    # DEPRECATED: Please use #add instead=.
    def add_servicegroup(payload)
      warn '[DEPRECATION] "add_servicegroup" is deprecated.  Please use "#add" instead.'
      self.add(payload)
    end

    def remove(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:serviceGroupName])
      return @netscaler.adapter.delete("config/servicegroup/#{payload[:serviceGroupName]}")
    end

    # DEPRECATED: Please use #remove instead=.
    def remove_servicegroup(payload)
      warn '[DEPRECATION] "remove_servicegroup" is deprecated.  Please use "#remove" instead.'
      self.remove(payload)
    end

    def show(payload)
      return @netscaler.adapter.get("config/servicegroup/", args) if payload.nil?
      return @netscaler.adapter.get("config/servicegroup/#{payload}")
    end

    # DEPRECATED: Please use #show instead=.
    def get_servicegroup(payload)
      warn '[DEPRECATION] "get_servicegroup" is deprecated.  Please use "#show" instead.'
      self.show(payload)
    end

    # DEPRECATED: Please use #show instead=.
    def get_servicegroups(payload)
      warn '[DEPRECATION] "get_servicegroup" is deprecated.  Please use "#show" instead.'
      self.show(payload)
    end

    def get_servicegroup_servicegroupmember_bindings(payload)
      return @netscaler.adapter.get("config/servicegroup_servicegroupmember_binding/#{payload}")
    end

    # DEPRECATED: Please use Netscaler::Lb::Monitor.bind instead=.
    def lbmonitor_servicegroup_binding(payload)
      warn '[DEPRECATION] "lbmonitor_servicegroup_binding" is deprecated.  Please use "Netscaler::Lb::Monitor.bind" instead.'
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:serviceGroupName, :monitorName])
      return @netscaler.adapter.post_no_body("config/lbmonitor_servicegroup_binding/#{payload[:monitorName]}?action=bind",  {'params' => {'action' => 'bind'}, 'lbmonitor_servicegroup_binding' => payload})
    end

    # DEPRECATED: Please use Netscaler::Lb::Monitor.unbind instead=.
    def lbmonitor_servicegroup_unbinding(payload)
      warn '[DEPRECATION] "lbmonitor_servicegroup_unbinding" is deprecated.  Please use "Netscaler::Lb::Monitor.unbind" instead.'
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:serviceGroupName, :monitorName])
      return @netscaler.adapter.post_no_body("config/lbmonitor_servicegroup_binding/#{payload[:monitorName]}?action=unbind", {'params' => {'action' => 'unbind'}, 'lbmonitor_servicegroup_binding' => payload})
    end

    def bind_servicegroup_servicegroupmember(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:serviceGroupName, :port, :serverName])
      return @netscaler.adapter.post_no_body("config/servicegroup_servicegroupmember_binding/#{payload['serviceGroupName']}?action=bind", {'params' => {'action' => 'bind'}, 'servicegroup_servicegroupmember_binding' => payload})
    end

    def unbind_servicegroup_servicegroupmember(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:serviceGroupName, :port, :serverName])
      return @netscaler.adapter.post_no_body("config/servicegroup_servicegroupmember_binding/#{payload['serviceGroupName']}?action=unbind", {'params' => {'action' => 'unbind'}, 'servicegroup_servicegroupmember_binding' => payload})
    end

  end
end
