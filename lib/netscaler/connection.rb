require 'rest_client'
require 'uri'
require 'json'

require 'netscaler/server'
require 'netscaler/service'
require 'netscaler/load_balancing'
require 'netscaler/http_adapter'
require 'netscaler/adapter'

module Netscaler
  class Connection
    def initialize(options={})
      missing_options=[]
      %w(username password hostname).each do |required_option|
        missing_options << required_option unless options.has_key?(required_option)
      end

      raise ArgumentError, "Required options are missing. #{missing_options.join(', ')}" if missing_options.length > 0

      @username = options['username']
      @password = options['password']

      @adapter = HttpAdapter.new :hostname => options['hostname']

      @load_balancing = LoadBalancing.new self
      @services = Service.new self
      @servers = Server.new self
    end

    def adapter
      return @adapter
    end

    def adapter=(value)
      @adapter=value
    end

    def services
      return @services
    end

    def load_balancing
      return @load_balancing
    end

    def servers
      return @servers
    end

    def session
      return @session
    end

    def login()
      payload = {
        'username' => @username,
        'password' => @password
      }

      result = @adapter.post('config/login', { 'login' => payload})
      @session = result['sessionid']
      return @session
    end

    def logout
      result = post_no_body('config/logout', {'logout'=>{}})
    end
  end
end
