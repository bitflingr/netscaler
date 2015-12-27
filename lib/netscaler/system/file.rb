require 'netscaler/netscaler_service'

module Netscaler
  class System
    class File < NetscalerService
      def initialize(netscaler)
        @netscaler = netscaler
      end

      def add(payload = {})
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        validate_payload(payload, [:filename, :filecontent, :filelocation])
        return @netscaler.adapter.post('config/systemfile', { 'systemfile' => payload })
      end
    end
  end
end
