$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'crystal'

# TODO: move to a helper.
def mashie(opts={})
  Hashie::Mash.new(opts)
end