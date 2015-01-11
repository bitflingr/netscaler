require 'netscaler/netscaler_service'

module Netscaler
  class Rewrite
    class Action < NetscalerService

      def initialize(netscaler)
        @netscaler=netscaler
      end

      def show(payload={})
        if payload[:name] != nil then
          validate_payload(payload, [:name])
          return @netscaler.adapter.get("config/rewriteaction/#{payload[:name]}")
        elsif payload == {} then
          return @netscaler.adapter.get('config/rewriteaction/')
        else
          raise ArgumentError, 'payload supplied must have been missing :name'
        end
      end

    end
  end
end

