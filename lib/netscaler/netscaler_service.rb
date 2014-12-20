module Netscaler
  class NetscalerService
    def validate_payload(payload, required_args)
      payload = Netscaler.hash_hack(payload)
      raise ArgumentError, 'payload must be a hash.' unless payload.is_a?(Hash)
      missing_args=[]
      required_args.each do |arg|
        missing_args << arg unless payload[arg] != nil
      end

      raise ArgumentError, "Missing required arguments. #{missing_args.join(', ')}" unless missing_args.length == 0;
    end



  end
end
