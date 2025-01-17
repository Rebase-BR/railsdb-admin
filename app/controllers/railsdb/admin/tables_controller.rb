module Railsdb
  module Admin
    class TablesController < ApplicationController
      before_action :set_connection, only: %i[ index ]

      # GET /tables
      def index
        @tables = @connection.tables.map do |table|
          { name: table,
            columns: @connection.columns(table).count,
            records: @connection.execute("SELECT COUNT(1) FROM #{table}").first['COUNT(1)']
          }
        end
      end

      # GET /table_data/:name
      def table_data
        @table = Table.explore(table_params[:name])
      end

      # GET /table_schema/:name
      def table_schema
        @table = Table.explore(table_params[:name])
      end

      private

      def set_connection
        @connection ||= ActiveRecord::Base.with_connection { |con| con }
      end

      def table_params
        params.permit(:name)
      end
    end
  end
end
