module Railsdb
  module Admin
    class TablesController < ApplicationController
      # GET /tables
      def index
        @tables = Database.info
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

      def table_params
        params.permit(:name)
      end
    end
  end
end
