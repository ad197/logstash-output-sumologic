# encoding: utf-8
require_relative './common'
require_relative './statistics'

module LogStash; module Outputs; class SumoLogic;
  class MessageQueue

    def initialize(stats, config)
      @queue = SizedQueue::new(config['queue_max'])
      @stats = stats
    end

    def enq(obj)
      if (obj.bytesize > 0)
        @queue.enq(obj)
        @stats.record_enque(obj)
      end
    end # def push

    def deq()
      obj = @queue.deq()
      @stats.record_deque(obj)
      obj
    end # def pop

    def drain()
      @queue.size.times.map {
        deq()
      }
    end # def drain

    def size()
      @queue.size()
    end # size
    
  end
end; end; end