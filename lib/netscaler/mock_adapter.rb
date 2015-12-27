require 'netscaler/adapter'
module Netscaler
  class MockAdapter < Adapter

    class Result

      def initialize
        @headers = {'content-type' => 'application/json'}
      end

      def header
        return @headers
      end

    end

    def initialize(args={})
      @result = Result.new

      @response = args[:body] if args.has_key?(:body)

    end

    def post(part, data, args={})
      url = get_uri(part)
      options = prepare_options(args)
      options[:content_type] = :json#'application/json'
      post_data = prepare_payload(data)
      #puts "POST /#{url}\n#{post_data}"

      return process_result(@result, @response)

      #@site[url].post post_data, options do |response, request, result|
      #  return process_result(result, response)
      #end
    end

    def post_no_body(part, data, args={})
      url = get_uri(part)
      options = prepare_options(args)
      options[:content_type] = :json #'application/x-www-form-urlencoded'
      post_data = prepare_payload(data)
      #@site[url].post post_data, options
      #puts "POST /#{url}\n#{post_data}"
      return process_result(@result, @response)
    end

    def put(part, data, args={})
      url = get_uri(part)
      options = prepare_options(args)
      options[:content_type] = :json#'application/json'
      put_data = prepare_payload(data)
      #puts "POST /#{url}\n#{put_data}"

      return process_result(@result, @response)

      #@site[url].post post_data, options do |response, request, result|
      #  return process_result(result, response)
      #end
    end

    def put_no_body(part, data, args={})
      url = get_uri(part)
      options = prepare_options(args)
      options[:content_type] = :json #'application/x-www-form-urlencoded'
      put_data = prepare_payload(data)
      #@site[url].put put_data, options
      #puts "POST /#{url}\n#{put_data}"
      return process_result(@result, @response)
    end

    def get(part, args={})
      url = get_uri(part)
      options = prepare_options(args)
      options[:content_type] = :json
      #puts "GET /#{url}"
      return process_result(@result, @response)
    end

    def delete(part, args={})
      url = get_uri(part)
      options = prepare_options(args)
      return process_result(@result, @response)
    end

  end
end
