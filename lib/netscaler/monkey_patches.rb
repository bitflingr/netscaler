module Netscaler
  # #hash_hack is mainly used in all the methods to provide backward compatibility for the older methods.
  #  Prior to this the method argument keys were string.  We later made them to symbols.  This allows users
  #  to use both but will eventually deprecate this.
  def self.hash_hack(hash)
    raise ArgumentError, 'payload must be a hash.' unless hash.is_a?(Hash)
    hash.default_proc = proc{|h, k| h.key?(k.to_s) ? h[k.to_s] : nil}
    return hash
  end

end