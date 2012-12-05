module Netscaler
  class LoadBalancing
    def initialize(netscaler)
      @netscaler=netscaler
    end


    def initialize(netscaler)
      @netscaler=netscaler
    end

    def add_service(service)
      return @netscaler.post_no_body('config/service/', {'service' => service})
    end

    def get_services(args={})

      return @netscaler.get("config/service/#{args[:name]}", args)
    end

  end
end
