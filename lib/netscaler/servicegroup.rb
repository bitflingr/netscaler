require 'netscaler/netscaler_service'

module Netscaler
  class ServiceGroup < NetscalerService
    def initialize(netscaler)
      @netscaler=netscaler
    end

    def add(payload)  # :args: :serviceGroupName => 'foo', :serviceType => 'HTTP'
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, [:serviceGroupName, :serviceType])
      return @netscaler.adapter.post_no_body("config/servicegroup/", "servicegroup" => payload)
    end

    def remove(payload) # :arg: serviceGroupName
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, [:serviceGroupName])
      return @netscaler.adapter.delete("config/servicegroup/#{payload[:serviceGroupName]}")
    end

    ##
    # argument is optional, if left empty it will return all servicegroups
    def show(payload={}) # :arg: servicegroupname
      return @netscaler.adapter.get("config/servicegroup/") if payload = {}
      return @netscaler.adapter.get("config/servicegroup/#{payload}")
    end

    def enable(payload) # :arg: service_group
      toggle('enable', payload)
    end

    def disable(payload) # :arg: service_group
      toggle('disable', payload)
    end

    def enable_server(payload) # :arg: service_group, serverName, port
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, [:serviceGroupName, :serverName, :port])
      return @netscaler.adapter.post('config/', {"params" =>
                                                     {"action" => "enable"},
                                                 "servicegroup" =>
                                                     {"servicegroupname" => payload[:serviceGroupName],
                                                      "serverName" => payload[:serverName],
                                                      "port" => payload[:port] }})
    end

    def disable_server(payload) # :arg: service_group, servername, port
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, [:serviceGroupName, :serverName, :port])
      return @netscaler.adapter.post('config/', {"params" =>
                                                     {"action" => "disable"},
                                                 "servicegroup" =>
                                                     {"servicegroupname" => payload[:serviceGroupName],
                                                      "serverName" => payload[:serverName],
                                                      "port" => payload[:port] }})
    end

    def show_bindings(payload)  # :args: servicegroupname
      return @netscaler.adapter.get("config/servicegroup_servicegroupmember_binding/#{payload}")
    end

    def bind(payload) # :args:  :serviceGroupName => 'foo', :port => '80', :serverName => 'bar'
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, [:serviceGroupName, :port, :serverName])
      return @netscaler.adapter.post_no_body("config/servicegroup_servicegroupmember_binding/#{payload['serviceGroupName']}?action=bind", {'params' => {'action' => 'bind'}, 'servicegroup_servicegroupmember_binding' => payload})
    end

    def unbind(payload) # :args:  :serviceGroupName => 'foo', :port => '80', :serverName => 'bar'
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, [:serviceGroupName, :port, :serverName])
      return @netscaler.adapter.post_no_body("config/servicegroup_servicegroupmember_binding/#{payload['serviceGroupName']}?action=unbind", {'params' => {'action' => 'unbind'}, 'servicegroup_servicegroupmember_binding' => payload})
    end

  private
    def toggle(toggle_action, payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, [:serviceGroupName])
      return @netscaler.adapter.post('config/', {"params" => {"action" => toggle_action}, "servicegroup" => {"servicegroupname" => payload[:service_group]}})
    end

  end
end
