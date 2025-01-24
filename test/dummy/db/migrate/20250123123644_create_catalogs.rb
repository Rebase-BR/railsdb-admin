class CreateCatalogs < ActiveRecord::Migration[8.0]
  def change
    create_table :catalogs do |t|
      t.string :title
      t.boolean :available

      t.timestamps
    end
  end
end
