require 'netscaler/adapter'
require 'rest-client'
require 'json'

module Netscaler
  class HttpAdapter < Adapter
    def initialize(args)
      @site = RestClient::Resource.new(args[:hostname], {
        :user       => args[:username],
        :password   => args[:password],
        :verify_ssl => args[:verify_ssl]
      })
    end

    def post_no_body(part, data, args={})
      url = get_uri(part)
      options = prepare_options(args)
      options[:content_type] = 'application/x-www-form-urlencoded'

      post_data = prepare_payload(data)
      @site[url].post post_data, options
    end

    def post(part, data, args={})
      url = get_uri(part)
      options = prepare_options(args)
      options[:content_type] = 'application/x-www-form-urlencoded'

      post_data = prepare_payload(data)
      @site[url].post post_data, options do |response, request, result|
        return process_result(result, response)
      end
    end

    def get(part, args={})
      url = get_uri(part)
      options = prepare_options(args)

      @site[url].get options do |response, request, result|
        return process_result(result, response)
      end
    end

    def delete(part, args={})
      url = get_uri(part)
      options = prepare_options(args)

      @site[url].delete options do |response, request, result|
        return process_result(result, response)
      end
    end

  end
end