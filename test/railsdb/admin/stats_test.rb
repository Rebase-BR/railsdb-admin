require "test_helper"

class Railsdb::Admin::StatsTest < ActiveSupport::TestCase
  setup do
    Railsdb::Admin::EventStore.instance.clear
    @stats_klass = Railsdb::Admin::Stats
  end

  test "returns an array of hashes" do
    Product.all.to_a
    catalog = Catalog.create!(title: "Catalog", available: true)
    Product.create!(name: "Product", code: 100, catalog: catalog)

    stats = @stats_klass.fetch_avg_durations
    assert_equal(3, stats.size)
  end

  test "returns one event for product creation" do
    catalog = Catalog.create!(title: "Catalog", available: true)
    Product.create!(name: "Product", code: 100, catalog: catalog)
    Product.create!(name: "Product good", code: 101, catalog: catalog)

    stats = @stats_klass.fetch_avg_durations
    assert_equal(2, stats.size)
  end

  test "returns sql query" do
    Product.all.to_a

    stats = @stats_klass.fetch_avg_durations

    first_event = "SELECT \"products\".* FROM \"products\""
    assert_equal(first_event, stats.first[:sql])
  end

  def create_events
    event = ActiveSupport::Notifications::Event.new("sql.active_record",
                                                  10.seconds.ago,
                                                  3.seconds.ago,
                                                  1,
                                                  { sql: "SELECT * FROM products" })
    event_2 = ActiveSupport::Notifications::Event.new("sql.active_record",
                                                      10.seconds.ago,
                                                      5.seconds.ago,
                                                      6,
                                                      { sql: "SELECT * FROM products" })
    Railsdb::Admin::EventStore.instance.add_event(event)
    Railsdb::Admin::EventStore.instance.add_event(event_2)
  end

  test "calculates avg duration" do
    create_events
    stats = @stats_klass.fetch_avg_durations

    assert_equal(6000, stats.first[:avg_duration].to_i)
  end

  test "counts the amount of query calls" do
    create_events
    stats = @stats_klass.fetch_avg_durations

    assert_equal(2, stats.first[:count])
  end
end
