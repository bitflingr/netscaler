require 'netscaler/netscaler_service'
require 'netscaler/system/file'
require 'netscaler/system/interface'

module Netscaler
  class System
    def initialize(netscaler)
      @netscaler = netscaler
    end

    def file
      File.new @netscaler
    end

    def interface
      Interface.new @netscaler
    end

    def stat
      @netscaler.adapter.get('stat/system')
    end

    def cpu
      @netscaler.adapter.get('stat/systemcpu')
    end

    def memory
      @netscaler.adapter.get('stat/systemmemory')
    end

    def hostname
       hostname = @netscaler.adapter.get('config/nshostname')
       hostname['nshostname'].first['hostname']
    end

  end
end
