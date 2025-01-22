module Railsdb
  module Admin
    # Plain Ruby object that provides methods to inspect info regarding a database table.
    #
    # t = Table.explore('table_name')
    #
    class Table
      def initialize(name)
        @name = name
      end

      attr_reader :name

      def self.explore(name)
        new(name).build_data
      end

      def build_data
        table_attrs = ActiveSupport::OrderedOptions.new()

        table_attrs.tap do |t|
          t.name         = name
          t.columns      = columns
          t.data         = data
          t.primary_key  = primary_key
          t.foreign_keys = foreign_keys
          t.indexes      = indexes
        end
      end

      private

      def columns = connection.columns(name)

      # TODO: add pagination or LIMIT to the SELECT query
      def data = connection.execute("SELECT * FROM #{name}")

      def primary_key = connection.primary_key(name)

      def foreign_keys = connection.foreign_keys(name)

      def indexes = connection.indexes(name)

      def connection
        @connection ||= ActiveRecord::Base.with_connection { |con| con }
      end
    end
  end
end
