module Netscaler
  class Service
    def initialize(netscaler)
      @netscaler=netscaler
    end

    def add_service(service)
      return @netscaler.adapter.post_no_body('config/service/', {'service' => service})
    end

    def get_service(args={})
      return @netscaler.adapter.get("config/service/#{args[:name]}", args)
    end
  end
end
