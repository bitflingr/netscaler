require 'netscaler/netscaler_service'

module Netscaler
  class System
    class Interface < NetscalerService
      def initialize(netscaler)
        @netscaler=netscaler
      end

      def show(payload={})
        if payload[:name] != nil then
          validate_payload(payload, [:name])
          return @netscaler.adapter.get("config/interface/#{payload[:name]}")
        elsif payload == {} then
          return @netscaler.adapter.get('config/interface/')
        else
          raise ArgumentError, 'payload supplied must have been missing :name'
        end
      end


      def stat(payload={})
        if payload[:name] != nil then
          validate_payload(payload, [:name])
          return @netscaler.adapter.get("stat/interface/#{payload[:name]}")
        elsif payload == {} then
          return @netscaler.adapter.get('stat/interface')
        else
          raise ArgumentError, 'payload cannot be null' if payload.nil?
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
