require 'test_helper'
require_relative '../../../../app/models/railsdb/admin/table'

class TableTest < ActiveSupport::TestCase
  test '#explore' do
    table = Railsdb::Admin::Table.explore('products')

    assert_equal('products', table.name)
  end
end
