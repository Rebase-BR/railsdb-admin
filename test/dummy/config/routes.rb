Rails.application.routes.draw do
  mount Railsdb::Admin::Engine => "/railsdb-admin"
end
