module Railsdb
  module Admin
    class EventStore
      attr_reader :events
      include Singleton

      def initialize
        @instance_mutex = Mutex.new
        @events = []
      end

      def clear
        @events.clear
      end

      def add_event(event)
        @instance_mutex.synchronize do
          @events << event
        end
      end
    end
  end
end
