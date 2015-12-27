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
      begin
        @site[url].post post_data, options
      rescue RestClient::Exception => e
        fr = Netscaler::Adapter::FailedRequest.new "Bad request", e.response , e
        raise fr
      end
    end

    def post(part, data, args={})
      url = get_uri(part)
      options = prepare_options(args)
      options[:content_type] = 'application/x-www-form-urlencoded'

      post_data = prepare_payload(data)
      begin
        @site[url].post post_data, options do |response, request, result|
          return process_result(result, response)
        end
      rescue RestClient::Exception => e
        fr = Netscaler::Adapter::FailedRequest.new "Bad request", e.response , e
        raise fr
      end
    end

    def put(part, data, args={})
      url = get_uri(part)
      options = prepare_options(args)
      options[:content_type] = 'application/x-www-form-urlencoded'

      put_data = prepare_payload(data, args)
      begin
        @site[url].put put_data, options do |response, request, result|
          return process_result(result, response)
        end
      rescue RestClient::Exception => e
        fr = Netscaler::Adapter::FailedRequest.new "Bad request", e.response , e
        raise fr
      end
    end

    def put_no_body(part, data, args={})
      url = get_uri(part)
      options = prepare_options(args)
      options[:content_type] = 'application/x-www-form-urlencoded'

      put_data = prepare_payload(data)
      begin
        @site[url].put put_data, options
      rescue RestClient::Exception => e
        fr = Netscaler::Adapter::FailedRequest.new "Bad request", e.response , e
        raise fr
      end
    end

    def get(part, args={})
      url = get_uri(part)
      options = prepare_options(args)

      begin
        @site[url].get options do |response, request, result|
          return process_result(result, response)
        end
      rescue RestClient::Exception => e
        fr = Netscaler::Adapter::FailedRequest.new "Bad request", e.response , e
        raise fr
      end
    end

    def delete(part, args={})
      url = get_uri(part)
      options = prepare_options(args)

      begin
        @site[url].delete options do |response, request, result|
          return process_result(result, response)
        end
      rescue RestClient::Exception => e
        fr = Netscaler::Adapter::FailedRequest.new "Bad request", e.response , e
        raise fr
      end
    end

  end
end
