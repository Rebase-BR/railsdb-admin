Railsdb::Admin::Engine.routes.draw do
  get "/hello", to: "hello#index"

  get "tables",             to: "tables#index"
  get "table_schema/:name", to: "tables#table_schema", as: :table_schema
  get "table_data/:name",   to: "tables#table_data",   as: :table_data
  get "stats",              to: "stats#index"

  resources :queries, only: %i[new create]
end
