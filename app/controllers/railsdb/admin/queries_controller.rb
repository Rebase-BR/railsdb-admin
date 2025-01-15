module Railsdb
  module Admin
    class QueriesController < ApplicationController
      before_action :set_connection, only: %i[ create ]

      # GET /queries/new
      def new; end

      # POST /queries
      def create
        @query_items = @connection.execute(query_params[:query])
        render :result
      end

      private

      def query_params
        params.permit(:query, {})
      end

      def set_connection
        @connection ||= ActiveRecord::Base.connection
      end
    end
  end
end

