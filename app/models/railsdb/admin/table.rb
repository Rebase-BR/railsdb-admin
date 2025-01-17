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

          # TODO: add pagination or LIMIT to the SELECT query
          connection do |con|
            t.columns      = con.columns(name)
            t.data         = con.execute("SELECT * FROM #{name}")
            t.primary_key  = con.primary_key(name)
            t.foreign_keys = con.foreign_keys(name)
            t.indexes      = con.indexes(name)
          end
        end
      end

      def columns = connection { it.columns(name) }

      def data = connection { it.execute("SELECT * FROM #{name}") }

      def primary_key = connection { it.primary_key(name) }

      def foreign_keys = connection { it.foreign_keys(name) }

      def indexes = connection { it.indexes(name) }

      private

      def connection(&block)
        ActiveRecord::Base.with_connection { |con| yield con }
      end
    end
  end
end
