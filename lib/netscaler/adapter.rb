module Netscaler
  class Adapter
    def session
      return @session
    end
    def session=(value)
      @session = value
    end


    :protected

    def prepare_payload(data)
      if data.is_a?(String)
        post_data = data
      else
        post_data = data.to_json
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
      if payload['severity'] =~ /error/i
        raise ArgumentError, "ErrorCode #{payload['errorcode']} Severity #{payload['severity']} -> #{payload['message']}"
      end
    end

    def process_result(result, response)
      #status_code = result.code.to_i

      if result.header['content-type'] =~ /application\/json/
        payload = JSON.parse(response)
        check_error(payload)
        return payload
      else
        raise Exception, 'Shit is broke'
      end
    end

    def get_uri(part)
      url = 'nitro/v1/'
      return url + part
    end

  end
end
