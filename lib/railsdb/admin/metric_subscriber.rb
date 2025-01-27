require 'prettyprint'
module Railsdb
  module Admin
    class MetricSubscriber
      def self.add_instrumentation
        ActiveSupport::Notifications.subscribe "sql.active_record" do |*args|
          event = ActiveSupport::Notifications::Event.new(*args)

          event.payload[:alt_name] = event.payload[:name] || name_from_sql(event.payload[:sql])
          unless ["SCHEMA", "TRANSACTION", "ActiveRecord::SchemaMigration Load"].include?(event.payload[:name])
            EventStore.instance.add_event(event)
          end
        end
      end

      private

      def self.name_from_sql(sql)
        sql.split(" ")[0] + " " + sql.match(/FROM\s(\w+)\s/i)&.captures&.first.to_s
      end
    end
  end
end