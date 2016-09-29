require 'netscaler/netscaler_service'

module Netscaler
  class Ha
    class Node < NetscalerService
      def initialize(netscaler)
        @netscaler=netscaler
      end

      def show(payload={})
        if payload[:id] != nil then
          validate_payload(payload, [:id])
          return @netscaler.adapter.get("config/hanode/#{payload[:id]}")
        elsif payload == {} then
          return @netscaler.adapter.get('config/hanode/')
        else
          raise ArgumentError, 'payload supplied must have been missing :id'
        end
      end


      def stat
        @netscaler.adapter.get('stat/hanode')
      end

    end
  end
end
