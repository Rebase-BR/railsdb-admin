class Railsdb::Admin::Railtie < Rails::Railtie
  config.to_prepare do
    Railsdb::Admin::MetricSubscriber.add_instrumentation
  end
end
