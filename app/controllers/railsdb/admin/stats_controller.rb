module Railsdb
  module Admin
    class StatsController < ApplicationController
      def index
        @stats = Railsdb::Admin::Stats.fetch_avg_durations
      end

      private
    end
  end
end
