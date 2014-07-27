require 'netscaler/netscaler_service'

module Netscaler
  class Policy
    class Stringmap < NetscalerService
      def initialize(netscaler)
        @netscaler = netscaler
      end

      def list(payload = nil) # :args: :name => 'foo'
        if payload !=nil then
          validate_payload(payload, [:name])
          return @netscaler.adapter.get("config/policystringmap/#{payload[:name]}")
        else
          return @netscaler.adapter.get("config/policystringmap/")
        end
      end

      def add(payload)  # :args: :name => 'foo'
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        validate_payload(payload, [:name])
        return @netscaler.adapter.post_no_body('config/policystringmap/', 'policystringmap' => payload)
      end

      def get(payload)  # :args: :name => 'foo'
        raise ArgumentError, 'arg must contain name of policystringmap! :name => "foo"' if payload.nil?
        validate_payload(payload, [:name])
        return @netscaler.adapter.get("config/policystringmap_pattern_binding/#{payload[:name]}")
      end

      def bind(payload)   # :args: :name => 'foo', :key => 'a', :value => '1'
        raise ArgumentError, 'payload cannot be null' if payload.nil?
        validate_payload(payload, [:name, :key, :value])
        return @netscaler.adapter.post_no_body('config/policystringmap_pattern_binding/', 'policystringmap_pattern_binding' => payload)
      end
    end
  end
end
