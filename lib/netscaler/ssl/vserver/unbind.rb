module Netscaler
  class Ssl
    class Vserver
      class Unbind < NetscalerService
        def initialize(netscaler)
          @netscaler=netscaler
        end

        def sslcertkey(payload)
          raise ArgumentError, 'payload cannot be null' if payload.nil?
          validate_payload(payload, [:vservername, :certkeyname])
          return @netscaler.adapter.post_no_body("config/sslvserver_sslcertkey_binding/#{payload[:vservername]}?action=unbind/", {'params' => {'action' => 'unbind'}, 'sslvserver_sslcertkey_binding' => payload})
        end

        def sslpolicy(payload)
          raise ArgumentError, 'payload cannot be null' if payload.nil?
          validate_payload(payload, [:vservername, :policyname, :priority])
          return @netscaler.adapter.delete("config/sslvserver_sslpolicy_binding/#{payload[:vservername]}", {'params' => { 'policyname' => payload[:policyname], 'priority' => payload[:priority]}})
        end

        def ecccurve(payload)
          raise ArgumentError, 'payload cannot be null' if payload.nil?
          validate_payload(payload, [:vservername, :ecccurvename])
          return @netscaler.adapter.delete("config/sslvserver_sslecccurve_binding/#{payload[:vservername]}", {'params' => {'ecccurvename' => payload[:ecccurename]}})
        end
      end
    end
  end
end
