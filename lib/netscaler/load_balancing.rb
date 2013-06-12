require 'netscaler/netscaler_service'

module Netscaler
  class LoadBalancing
    def initialize(netscaler)
      @netscaler=netscaler
    end

    def get_lbvserver(args={})
      return @netscaler.adapter.get("config/lbvserver/#{args[:name]}", args)
    end

    def get_lbvservers()
      return @netscaler.adapter.get("config/lbvserver/")
    end

    def get_lbvserver_binding(args={})
      raise ArgumentError, 'payload cannot be null' if args.nil?
      validate_payload(args, %w(name))
      return @netscaler.adapter.get("config/lbvserver_binding/#{args[:name]}", args)
    end

    def add_lbvserver(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, %w(name serviceType ipv46 port))
      return @netscaler.adapter.post_no_body('config/lbvserver/', {'lbvserver' => payload})
    end

    def add_lbvserver_servicegroup_binding(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      validate_payload(payload, %w(name servicegroupname))
      return @netscaler.adapter.post_no_body("config/lbvserver_servicegroup_binding/#{payload['name']}?action=bind/", {'lbvserver_servicegroup_binding' => payload})
    end
  end
end
