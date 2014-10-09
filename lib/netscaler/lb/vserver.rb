require 'netscaler/netscaler_service'

module Netscaler
  class Lb
    class Vserver < NetscalerService
      def initialize(netscaler)
        @netscaler=netscaler
      end

      def show(args={})
        if args[:name] == nil then
          return @netscaler.adapter.get('config/lbvserver/')
        else
          return @netscaler.adapter.get("config/lbvserver/#{args[:name]}", args)
        end
      end

      def show_binding(payload)
        return @netscaler.adapter.get("config/lbvserver_binding/#{payload}")
      end

      def add(payload)
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        validate_payload(payload, %w(name serviceType ipv46 port))
        return @netscaler.adapter.post_no_body('config/lbvserver/', {'lbvserver' => payload})
      end

      def bind(payload)

      end

      def add_lbvserver_servicegroup_binding(payload)
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        validate_payload(payload, %w(name servicegroupname))
        return @netscaler.adapter.post_no_body("config/lbvserver_servicegroup_binding/#{payload['name']}?action=bind/", {'lbvserver_servicegroup_binding' => payload})
      end

      def add_lbvserver_service_binding(payload)
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        validate_payload(payload, %w(name servicename))
        return @netscaler.adapter.post_no_body("config/lbvserver_service_binding/#{payload['name']}?action=bind/", {'lbvserver_service_binding' => payload})
      end
    end
  end
end
