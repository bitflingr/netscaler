require 'netscaler/policy/stringmap'

module Netscaler
  class Policy

    def initialize(netscaler)
      @netscaler = netscaler
    end

    def stringmap
      Stringmap.new @netscaler
    end

  end
end