module Netscaler
  class Cs
    class Vserver
      class Unbind < NetscalerService
        def initialize(netscaler)
          @netscaler=netscaler
        end

=begin

        object=
            {
                'params': {'action':'bind'},
            "csvserver_cspolicy_binding":
            {
                "name":"cs_test_80",
            "targetvserver":"lb_thumby_80",
            "policyname": "cs_test_rule",
            "priority": "800",

        }
        }

=end
        def cspolicy(payload)
          raise ArgumentError, 'payload cannot be null' if payload.nil?
          validate_payload(payload, [:name])
          # Need to find a way to throw optional args as well, including :policyname and :priority
          return @netscaler.adapter.post_no_body("config/csvserver_cspolicy_binding/#{payload['name']}?action=unbind/", {'params' => {'action' => 'unbind'}, 'csvserver_cspolicy_binding' => payload})
        end

        # Creates new methods that share the same args but have slightly different endpoints
        %w( rewrite responder).each do |type|

          define_method(type + 'policy') do |payload|
            raise ArgumentError, 'payload cannot be null' if payload.nil?
            validate_payload(payload, [:name, :policyName])
            return @netscaler.adapter.post_no_body("config/csvserver_#{type}policy_binding/#{payload['name']}?action=unbind/", {'params' => {'action' => 'unbind'}, "lbvserver_#{type}policy_binding" => payload})
          end

        end

      end
    end
  end
end



