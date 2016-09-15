require 'netscaler/netscaler_service'
require 'netscaler/system/file'
require 'netscaler/system/inferface'

module Netscaler
  class System
    def initialize(netscaler)
      @netscaler = netscaler
    end

    def file
      File.new @netscaler
    end
  end
end
