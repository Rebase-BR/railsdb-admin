module Railsdb
  module Admin
    class Railsdb::Admin::HelloController < Railsdb::Admin::ApplicationController
      def index
        render plain: 'Hello, Railsdb::Admin!'
      end
    end
  end
end
