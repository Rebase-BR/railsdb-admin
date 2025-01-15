module Railsdb
  module Admin
    class Railsdb::Admin::TablesController < Railsdb::Admin::ApplicationController
      before_action :set_connection, only: %i[ index table_data table_schema ]

      def index
        @tables = @connection.tables
      end

      def table_data
        @table = table_params[:name]
        @columns = @connection.columns(@table)
        @data = @connection.execute("SELECT * FROM #{@table}")
      end

      def table_schema
        @table = table_params[:name]
        @columns = @connection.columns(@table)
        @primary_key = @connection.primary_key(@table)
        @foreign_keys = @connection.foreign_keys(@table)
        @indexes = @connection.indexes(@table)
      end

      private

      def set_connection
        @connection ||= ActiveRecord::Base.connection
      end

      def table_params
        params.permit(:name)
      end
    end
  end
end
