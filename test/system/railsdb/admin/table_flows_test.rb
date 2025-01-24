require "application_system_test_case"

class TableFlowsTest < ApplicationSystemTestCase
  test "list application tables" do
    visit "railsdb/tables"

    # Check navigation tabs
    within ".tabs.is-boxed" do
      within ".is-active" do
        assert_link "Tables", href: "/railsdb/tables"
      end

      assert_link "SQL run", href: "/railsdb/queries/new"
      assert_link "Statistics", href: "#"
    end

    # Check the main table
    assert_selector "table.table.is-fullwidth.is-striped.is-hoverable"

    # Verify table headers
    assert_selector "th", text: "Table Name"
    assert_selector "th", text: "Records"
    assert_selector "th", text: "Columns"
    assert_selector "th", text: "Actions"

    # Verify that table products is listed
    assert_selector "td", text: "Products"

    # Check action buttons
    assert_link "Schema", class: "button is-info"
    assert_link "Data", class: "button is-primary"
  end


  test "view table data" do
    visit "/railsdb/table_data/products"

    within ".level-left" do
      assert_text "Products"
    end

    within ".level-right" do
      assert_link "Inspect schema", href: "/railsdb/table_schema/products", class: "button is-primary"
    end

    # Check the main table
    assert_selector "table.table.is-fullwidth.is-striped.is-hoverable"

    # Verify table headers
    assert_selector "th", text: "id"
    assert_selector "th", text: "name"
    assert_selector "th", text: "code"
    assert_selector "th", text: "created_at"
    assert_selector "th", text: "updated_at"
  end


  test "view table schema details" do
    visit "/railsdb/table_schema/products"

    # Verify control pane
    within ".level-left" do
      assert_text "Products schema"
    end

    within ".level-right" do
      assert_link "Explore table data", href: "/railsdb/table_data/products", class: "button is-primary"
    end

    # List all tables
    tables = all(".table.table.is-fullwidth.is-striped.is-hoverable")

    within tables[0] do
      assert_selector "th", text: "name"
      assert_selector "th", text: "sql_type_metadata"
    end

    within tables[1] do
      assert_selector "caption", text: "Foreign keys"
      assert_selector "th",      text: "from_table"
    end

    within tables[2] do
      assert_selector "caption", text: "Indexes"
      assert_selector "th",      text: "unique"
    end
  end
end
