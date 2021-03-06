module Adapters
  class << self
    def process(event, options = Hashie::Mash.new)
      listeners[event.to_sym].each do |adapter|
        puts "[#{adapter.name}] processing #{event}: #{options.inspect}"
        adapter.new(options).send("process_#{event}")
        puts "[#{adapter.name}] processed #{event}"
      end
    end

    def listeners
      @listeners ||= Hash.new { |h,k| h[k] = [] }
    end
  end

  module Subscribable
    def subscribe!(*events)
      Array(events).each do |event|
        Adapters.listeners[event.to_sym] << self
      end
    end
  end
end

require 'adapters/base'
require 'adapters/pivotal'
require 'adapters/github'
require 'adapters/email'
