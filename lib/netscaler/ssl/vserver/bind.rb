module Netscaler
  class Ssl
    class Vserver
      class Bind < NetscalerService
        def initialize(netscaler)
          @netscaler=netscaler
        end

        def sslcertkey(payload)
          raise ArgumentError, 'payload cannot be null' if payload.nil?
          validate_payload(payload, [:name, :certkeyname])
          return @netscaler.adapter.post_no_body("config/sslvserver_sslcertkey_binding/#{payload[:vservername]}", {'params' => {'action' => 'bind'}, 'sslvserver_sslcertkey_binding' => payload})
        end

      end
    end
  end
end



