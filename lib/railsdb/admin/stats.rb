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

          {
            sql: payload[:sql].split(" /*").first,
            avg_duration: avg_duration.round(2),
            name: payload[:name] || payload[:alt_name],
            count: events.size,
            max_duration: durations.max.round(2),
            min_duration: durations.min.round(2)
          }
        end.sort_by { |event| event[:avg_duration] }.reverse
      end

      private
    end
  end
end
