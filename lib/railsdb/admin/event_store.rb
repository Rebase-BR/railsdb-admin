module Railsdb
  module Admin
    class EventStore
      attr_reader :events

      @@instance_mutex = Mutex.new

      def initialize
        @events = []
      end

      def self.instance
        return @instance if @instance
    
        @@instance_mutex.synchronize do
          @instance ||= new
        end
    
        @instance
      end

      def clear
        @events.clear
      end

      def add_event(event)
        @@instance_mutex.synchronize do 
          @events << event
        end
      end
    end
  end
end