require 'netscaler/netscaler_service'

module Netscaler
  class Cs
    class Policylabel < NetscalerService

      def initialize(netscaler)
        @netscaler=netscaler
      end

      def show(payload={})
        if payload[:name] != nil then
          validate_payload(payload, [:name])
          return @netscaler.adapter.get("config/cspolicylabel/#{payload[:name]}")
        elsif payload == {} then
          return @netscaler.adapter.get('config/cspolicylabel/')
        else
          raise ArgumentError, 'payload supplied must have been missing :name'
        end
      end

      def show_binding(payload)
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        validate_payload(payload, [:name])
        return @netscaler.adapter.get("config/cspolicylabel_binding/#{payload[:name]}")
      end

    end
  end
end

