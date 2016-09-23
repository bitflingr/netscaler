require 'netscaler/ha/node'

module Netscaler
  class Ha
    def initialize(netscaler)
      @netscaler = netscaler
    end

    def node
      Node.new @netscaler
    end

  end
end
