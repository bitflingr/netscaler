require 'netscaler/netscaler_service'

module Netscaler
  class ServiceGroup < NetscalerService
    def initialize(netscaler)
      @netscaler=netscaler
    end

    def add(payload)  # :args: :serviceGroupName => 'foo', :serviceType => 'HTTP'
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:serviceGroupName, :serviceType])
      return @netscaler.adapter.post_no_body("config/servicegroup/", "servicegroup" => payload)
    end

    ##
    # :category: Deprecated Methods
    # DEPRECATED: Please use #add instead=.
    def add_servicegroup(payload)
      warn '[DEPRECATION] "add_servicegroup" is deprecated.  Please use "#add" instead.'
      self.add(payload)
    end

    def remove(payload) # :arg: serviceGroupName
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:serviceGroupName])
      return @netscaler.adapter.delete("config/servicegroup/#{payload[:serviceGroupName]}")
    end

    ##
    # :category: Deprecated Methods
    # DEPRECATED: Please use #remove instead=.
    def remove_servicegroup(payload)
      warn '[DEPRECATION] "remove_servicegroup" is deprecated.  Please use "#remove" instead.'
      self.remove(payload)
    end

    ##
    # argument is optional, if left empty it will return all servicegroups
    def show(payload) # :arg: servicegroupname
      return @netscaler.adapter.get("config/servicegroup/", args) if payload.nil?
      return @netscaler.adapter.get("config/servicegroup/#{payload}")
    end

    def enable(payload) # :arg: service_group
      toggle('enable', payload)
    end

    def disable(payload) # :arg: service_group
      toggle('disable', payload)
    end

    ##
    # :category: Deprecated Methods
    # DEPRECATED: Please use #show instead=.
    def get_servicegroup(payload)
      warn '[DEPRECATION] "get_servicegroup" is deprecated.  Please use "#show" instead.'
      self.show(payload)
    end

    ##
    # :category: Deprecated Methods
    # DEPRECATED: Please use #show instead=.
    def get_servicegroups(payload)
      warn '[DEPRECATION] "get_servicegroup" is deprecated.  Please use "#show" instead.'
      self.show(payload)
    end

    def show_bindings(payload)  # :args: servicegroupname
      return @netscaler.adapter.get("config/servicegroup_servicegroupmember_binding/#{payload}")
    end

    ##
    # :category: Deprecated Methods
    # DEPRECATED: Please use #show_bindings instead=.
    def get_servicegroup_servicegroupmember_bindings(payload)
      warn '[DEPRECATION] "get_servicegroup_servicegroupmember_bindings" is deprecated.  Please use "#show_bindings" instead.'
      self.show_bindings(payload)
    end

    ##
    # :category: Deprecated Methods
    # DEPRECATED: Please use Netscaler::Lb::Monitor.bind instead=.
    def lbmonitor_servicegroup_binding(payload)
      warn '[DEPRECATION] "lbmonitor_servicegroup_binding" is deprecated.  Please use "Netscaler::Lb::Monitor.bind" instead.'
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:serviceGroupName, :monitorName])
      return @netscaler.adapter.post_no_body("config/lbmonitor_servicegroup_binding/#{payload[:monitorName]}?action=bind",  {'params' => {'action' => 'bind'}, 'lbmonitor_servicegroup_binding' => payload})
    end

    ##
    # :category: Deprecated Methods
    # DEPRECATED: Please use Netscaler::Lb::Monitor.unbind instead=.
    def lbmonitor_servicegroup_unbinding(payload)
      warn '[DEPRECATION] "lbmonitor_servicegroup_unbinding" is deprecated.  Please use "Netscaler::Lb::Monitor.unbind" instead.'
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:serviceGroupName, :monitorName])
      return @netscaler.adapter.post_no_body("config/lbmonitor_servicegroup_binding/#{payload[:monitorName]}?action=unbind", {'params' => {'action' => 'unbind'}, 'lbmonitor_servicegroup_binding' => payload})
    end

    def bind(payload) # :args:  :serviceGroupName => 'foo', :port => '80', :serverName => 'bar'
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:serviceGroupName, :port, :serverName])
      return @netscaler.adapter.post_no_body("config/servicegroup_servicegroupmember_binding/#{payload['serviceGroupName']}?action=bind", {'params' => {'action' => 'bind'}, 'servicegroup_servicegroupmember_binding' => payload})
    end


    ##
    # :category: Deprecated Methods
    # DEPRECATED: Please use #bind instead=.
    def bind_servicegroup_servicegroupmember(payload)
      warn '[DEPRECATION] "bind_servicegroup_servicegroupmember" is deprecated.  Please use #bind instead.'
      self.bind(payload)
    end

    def unbind(payload) # :args:  :serviceGroupName => 'foo', :port => '80', :serverName => 'bar'
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:serviceGroupName, :port, :serverName])
      return @netscaler.adapter.post_no_body("config/servicegroup_servicegroupmember_binding/#{payload['serviceGroupName']}?action=unbind", {'params' => {'action' => 'unbind'}, 'servicegroup_servicegroupmember_binding' => payload})
    end

    ##
    # :category: Deprecated Methods
    # DEPRECATED: Please use #unbind instead=.
    def unbind_servicegroup_servicegroupmember(payload)
      warn '[DEPRECATION] "unbind_servicegroup_servicegroupmember" is deprecated.  Please use #unbind instead.'
      self.unbind(payload)
    end

  private
    def toggle(toggle_action, payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:serviceGroupName])
      return @netscaler.adapter.post('config/', {"params" => {"action" => toggle_action}, "servicegroup" => {"servicegroupname" => payload[:service_group]}})
    end

  end
end
