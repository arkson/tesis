class CreateAlquileres < ActiveRecord::Migration
  def change
    create_table :alquileres do |t|
      t.references :line_item
      t.references :usuario
      t.date :fecha_fin
      t.string :estatus

      t.timestamps
    end
    add_index :alquileres, :line_item_id
    add_index :alquileres, :usuario_id
  end
end
