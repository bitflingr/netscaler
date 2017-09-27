require 'netscaler/netscaler_service'

module Netscaler
  class Cs
    class Vserver < NetscalerService
      def initialize(netscaler)
        @netscaler=netscaler
      end

      def show(payload={})
        if payload[:name] != nil then
          validate_payload(payload, [:name])
          return @netscaler.adapter.get("config/csvserver/#{payload[:name]}")
        elsif payload == {} then
          return @netscaler.adapter.get('config/csvserver/')
        else
          raise ArgumentError, 'payload supplied must have been missing :name'
        end
      end

      def show_binding(payload)
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        validate_payload(payload, [:name])
        return @netscaler.adapter.get("config/csvserver_binding/#{payload[:name]}")
      end

      def remove(payload) # :args: :name
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        validate_payload(payload, [:name])
        return @netscaler.adapter.delete("config/csvserver/#{payload[:name]}")
      end

      def add(payload)
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        validate_payload(payload, [:name, :serviceType, :ipv46, :port])
        return @netscaler.adapter.post_no_body('config/csvserver/', {'csvserver' => payload})
      end

      def stat(payload={})
        if payload[:name] != nil then
          validate_payload(payload, [:name])
          return @netscaler.adapter.get("stat/csvserver/#{payload[:name]}")
        elsif payload == {} then
          return @netscaler.adapter.get('stat/csvserver')
        else
          raise ArgumentError, 'payload supplied must have been missing :name'
        end
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
