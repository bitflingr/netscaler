require 'netscaler/policy/stringmap'

module Netscaler

=begin

  Keeping with the command grouping in NSCLI, the Policy class is meant
  to be used as a place holder for all subcommands that belong under
  policy command group.  Ex.

  add policy expression
  add policy httpCallout
  add policy map
  add policy patset
  add policy stringmap

=end

  class Policy

    def initialize(netscaler)
      @netscaler = netscaler
    end

    def stringmap
      Stringmap.new @netscaler
    end

  end
end