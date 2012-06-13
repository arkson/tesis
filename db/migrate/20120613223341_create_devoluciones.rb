class CreateDevoluciones < ActiveRecord::Migration
  def change
    create_table :devoluciones do |t|
      t.references :alquiler
      t.date :fecha
      t.string :estatus
      t.references :line_item

      t.timestamps
    end
    add_index :devoluciones, :alquiler_id
    add_index :devoluciones, :line_item_id
  end
end
