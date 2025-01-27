require "pry"
require 'prettyprint'
module Railsdb
  module Admin
    module Stats
      def self.fetch_avg_durations
        raw_events = EventStore.instance.events

        raw_events.group_by { |event| event.payload[:sql] }.map do |_, events|
          durations = events.map(&:duration)
          avg_duration = durations.sum / durations.size
          first_event = events.first
          payload = first_event.payload
          gc_time = events.map(&:gc_time).sum

          {
            sql: payload[:sql].split(" /*").first,
            avg_duration: avg_duration,
            name: payload[:name] || payload[:alt_name],
            count: events.size,
            max_duration: durations.max,
            min_duration: durations.min,
            gc_time: gc_time
          }
        end
      end

      private
    end
  end
end
