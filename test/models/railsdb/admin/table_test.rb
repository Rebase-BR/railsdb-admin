require 'test_helper'

class TableTest < ActiveSupport::TestCase
  test '#explore' do
    table = Railsdb::Admin::Table.explore('products')

    assert_equal('products', table.name)
  end
end
