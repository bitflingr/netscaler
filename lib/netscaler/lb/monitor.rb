require 'netscaler/netscaler_service'

module Netscaler
  class Lb
    class Monitor < NetscalerService

      def initialize(netscaler)
        @netscaler = netscaler
      end

      def add(payload)  # :args: :monitorName => 'HTTP-updates.dev.rs.com', :serviceType => 'HTTP'
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        validate_payload(payload, [:monitorName, :type])
        return @netscaler.adapter.post_no_body("config/lbmonitor/", "lbmonitor" => payload)
      end

      # not working. always dies saying it wants a type no matter how i pass the type. :)
      def remove(payload)  # :args: :monitorName => 'HTTP-updates.dev.rs.com'
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        validate_payload(payload, [:monitorName, :type])
        return @netscaler.adapter.delete("config/lbmonitor/#{payload[:monitorName]}", "lbmonitor" => payload)
      end

      def show(payload) # :args: :monitorName => 'http', :entityName => 'foo' :entityType => '[service|servicegroup]'
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        validate_payload(payload, [:monitorName])
        return @netscaler.adapter.get("config/lbmonitor/#{payload[:monitorName]}")
      end

      def show_binding(payload) # :args: :monitorName => 'http', :entityName => 'foo' :entityType => '[service|servicegroup]'
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        validate_payload(payload, [:monitorName, :entityType])
        valid_entityTypes = %w(service servicegroup)
        raise ArgumentError, ":entityType does not equal one of the following: #{valid_entityTypes.flatten}" unless valid_entityTypes.include?(payload[:entityType])

        return @netscaler.adapter.get("config/lbmonbindings_#{payload[:entityType]}_binding/#{payload[:monitorName]}")
      end

      def bind(payload) # :args: :monitorName => 'http', :entityName => 'foo' :entityType => '[service|servicegroup]'
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        validate_payload(payload, [:monitorName, :entityName, :entityType])
        valid_entityTypes = %w(service servicegroup)
        raise ArgumentError, ":entityType does not equal one of the following: #{valid_entityTypes.flatten}" unless valid_entityTypes.include?(payload[:entityType])
        new_payload = {:monitorName => payload[:monitorName],
                       :"#{payload[:entityType]}Name" => payload[:entityName]}

        return @netscaler.adapter.post_no_body("config/lbmonitor_#{payload[:entityType]}_binding/#{payload[:monitorName]}?action=bind",
                                                {'params' => {'action' => 'bind'}, "lbmonitor_#{payload[:entityType]}_binding" => new_payload})
      end

      def unbind(payload) # :args: :monitorName => 'http', :entityName => 'foo' :entityType => '[service|servicegroup]'
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        validate_payload(payload, [:monitorName, :entityName, :entityType])
        valid_entityTypes = %w(service servicegroup)
        raise ArgumentError, ":entityType does not equal one of the following: #{valid_entityTypes.flatten}" unless valid_entityTypes.include?(payload[:entityType])
        new_payload = {:monitorName => payload[:monitorName],
                       :"#{payload[:entityType]}Name" => payload[:entityName]}

        return @netscaler.adapter.post_no_body("config/lbmonitor_servicegroup_binding/#{payload[:monitorName]}?action=unbind",
                                               {'params' => {'action' => 'unbind'}, 'lbmonitor_servicegroup_binding' => new_payload})
      end

    end
  end
end
