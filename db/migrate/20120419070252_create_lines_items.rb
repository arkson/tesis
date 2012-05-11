class CreateLinesItems < ActiveRecord::Migration
  def change
    create_table :lines_items do |t|
      t.references :ejemplar
      t.references :cart

      t.timestamps
    end
    add_index :lines_items, :ejemplar_id
    add_index :lines_items, :cart_id
  end
end
