module Railsdb
  module Admin
    # Plain Ruby object that provides methods to expose info,
    # regarding database and its tables
    #
    # t = Database.info
    #
    class Database
      def self.info
        new.info
      end

      def info
        # TODO: add pagination or LIMIT to the SELECT query
        # Also, Postgres an others DB outputs might differ from SQLite
        tables.map do |table|
          ActiveSupport::OrderedOptions.new.tap do |attrs|
            attrs.name    = table
            attrs.columns = connection.columns(table).count
            attrs.records = connection.execute("SELECT COUNT(1) FROM #{table}").first['COUNT(1)']
          end
        end
      end

      private

      def tables = connection.tables

      def connection
        ActiveRecord::Base.with_connection { |con| con }
      end
    end
  end
end
