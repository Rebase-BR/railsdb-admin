require "test_helper"

class TableTest < ActiveSupport::TestCase
  setup do
    @table_name = "products"
    @table_klass = Railsdb::Admin::Table
    @connection = ActiveRecord::Base.with_connection { |con| con }
  end

  test "#explore returns obj with table name" do
    table = @table_klass.explore(@table_name)

    assert_equal(@table_name, table.name)
  end

  test "#explore returns obj with table columns" do
    expected_columns = @connection.columns(@table_name).map(&:name)

    table_columns = @table_klass.explore(@table_name).columns.map(&:name)

    assert_equal(expected_columns, table_columns)
  end

  test "#explore returns obj with table data" do
    expected_data = Product.all.map(&:attributes)

    data = @table_klass.explore(@table_name).data.to_a

    assert_equal(expected_data, data)
  end

  test "#explore returns obj with table primary key" do
    expected_primary_key = @connection.primary_key(@table_name)

    table_pk = @table_klass.explore(@table_name).primary_key

    assert_equal(expected_primary_key, table_pk)
  end

  test "#explore returns obj with table foreign keys" do
    expected_foreign_keys = @connection.foreign_keys(@table_name).map(&:to_h)

    table_fk = @table_klass.explore(@table_name).foreign_keys.map(&:to_h)

    assert_equal(expected_foreign_keys, table_fk)
  end

  test "#explore returns obj with table indexes" do
    expected_indexes = @connection.indexes(@table_name).map(&:as_json)

    table_indexes = @table_klass.explore(@table_name).indexes.map(&:as_json)

    assert_equal(expected_indexes, table_indexes)
  end
end
