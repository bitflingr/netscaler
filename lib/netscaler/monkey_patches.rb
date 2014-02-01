module Netscaler

  def self.hash_hack(hash)
    hash.default_proc = proc{|h, k| h.key?(k.to_s) ? h[k.to_s] : nil}
    return hash
  end

end