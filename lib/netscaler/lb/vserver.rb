require 'netscaler/netscaler_service'

module Netscaler
  class Lb
    class Vserver < NetscalerService
      def initialize(netscaler)
        @netscaler=netscaler
      end

      def show(payload={})
        if payload[:name] == nil then
          return @netscaler.adapter.get('config/lbvserver/')
        else
          return @netscaler.adapter.get("config/lbvserver/#{payload[:name]}", args)
        end
      end

      def show_binding(payload)
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        payload = Netscaler.hash_hack(payload)
        validate_payload(payload, [:name])
        return @netscaler.adapter.get("config/lbvserver_binding/#{payload[:name]}")
      end

      # def add(payload)
      #   raise ArgumentError, 'payload cannot be null' if payload.nil?
      #   payload = Netscaler.hash_hack(payload)
      #   validate_payload(payload, [:name, :serviceType, :ipv46, :port])
      #   return @netscaler.adapter.post_no_body('config/lbvserver/', {'lbvserver' => payload})
      # end

      def remove(payload) # :args: :name
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        payload = Netscaler.hash_hack(payload)
        validate_payload(payload, [:name])
        return @netscaler.adapter.delete("config/lbvserver/#{payload[:name]}")
      end

      def add(payload)
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        payload = Netscaler.hash_hack(payload)
        validate_payload(payload, [:name, :serviceType, :ipv46, :port])
        return @netscaler.adapter.post_no_body('config/lbvserver/', {'lbvserver' => payload})
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
