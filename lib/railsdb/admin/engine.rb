module Railsdb
  module Admin
    class Engine < ::Rails::Engine
      isolate_namespace Railsdb::Admin
    end
  end
end
