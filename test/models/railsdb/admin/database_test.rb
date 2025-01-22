require 'test_helper'

class DatabaseTest < ActiveSupport::TestCase
  setup do
    @database_klass = Railsdb::Admin::Database
    @connection = ActiveRecord::Base.with_connection { |con| con }
  end

  test '#info returns all table names' do
    expected_tables = @connection.tables

    db_info = @database_klass.info

    assert_equal(expected_tables, db_info.map(&:name))
  end

  test '#info includes column counts of a table' do
    expected_column_count = Product.last.attributes.count

    db_info = @database_klass.info.find { |t| t.name == 'products'}

    assert_equal(expected_column_count, db_info.columns)
  end

  test '#info includes record counts of a table' do
    expected_record_count = Product.count

    db_info = @database_klass.info.find { |t| t.name == 'products'}

    assert_equal(expected_record_count, db_info[:records])
  end
end
