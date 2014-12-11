module Netscaler
  class Adapter
    def session
      return @session
    end
    def session=(value)
      @session = value
    end

    class FailedRequest < StandardError
      attr_reader :payload

      def initialize(message, payload, rest_client_exception=nil)
        super(message)
        @payload = payload
        @rest_client_exception = rest_client_exception
      end
    end

    :protected

    def prepare_payload(data)
      if data.is_a?(String)
        post_data = "object=#{data}"
      else
        post_data = "object=#{data.to_json}"
      end
      return post_data
    end

    def prepare_options(args)
      options = {
          :cookies=>{}
      }
      unless @session.nil?
        options[:cookies]['NITRO_AUTH_TOKEN'] = @session
      end
      options[:accept] = :json
      options[:params] = args[:params] if args.has_key?(:params)

      return options
    end

    def check_error(payload)
      if payload['errorcode'] != 0
        e = FailedRequest.new("ErrorCode #{payload['errorcode']} -> #{payload['message']}", payload)
        raise e
      end
    end

    def process_result(result, response)
      if result.header['content-type'] =~ /application\/json/
        payload = JSON.parse(response)
        check_error(payload)
        return payload
      else
        e = FailedRequest.new("Unexpected Content Type Header #{result.header['content-type']}", response)
        raise e
      end
    end

    def get_uri(part)
      url = 'nitro/v1/'
      return url + part
    end

  end
end
