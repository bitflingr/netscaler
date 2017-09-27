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
        else
          return @netscaler.adapter.get('config/interface/')
        end
      end


      def stat(payload={})
        if payload[:name] != nil then
          validate_payload(payload, [:name])
          return @netscaler.adapter.get("stat/interface/#{payload[:name]}")
        else
          return @netscaler.adapter.get('stat/interface')
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
