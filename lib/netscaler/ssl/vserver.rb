require 'netscaler/netscaler_service'

module Netscaler
  class Ssl
    class Vserver < NetscalerService
      def initialize(netscaler)
        @netscaler=netscaler
      end

      def show(payload={})
        if payload[:name] != nil then
          validate_payload(payload, [:name])
          return @netscaler.adapter.get("config/sslvserver/#{payload[:name]}")
        elsif payload == {} then
          return @netscaler.adapter.get('config/sslvserver/')
        else
          raise ArgumentError, 'payload supplied must have been missing :name'
        end
      end

      def show_binding(payload)
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        validate_payload(payload, [:name])
        return @netscaler.adapter.get("config/sslvserver_binding/#{payload[:name]}")
      end

      def remove(payload) # :args: :name
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        validate_payload(payload, [:name])
        return @netscaler.adapter.delete("config/sslvserver/#{payload[:name]}")
      end

      def add(payload)
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        validate_payload(payload, [:name, :serviceType, :ipv46, :port])
        return @netscaler.adapter.post_no_body('config/sslvserver/', {'sslvserver' => payload})
      end

      def stat(payload)
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        validate_payload(payload, [:name])
        return @netscaler.adapter.get("stat/sslvserver/#{payload[:name]}")
      end

      def bind
        Bind.new @netscaler
      end

      def unbind
        Unbind.new @netscaler
      end

    end
  end
end
