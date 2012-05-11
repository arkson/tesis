class CreateEjemplares < ActiveRecord::Migration
  def change
    create_table :ejemplares do |t|
      t.string :numero_ejemplar
      t.decimal :costo_alquiler
      t.string :tipo_adquisicion
      t.date :fecha_ingreso
      t.text :observacion
      t.string :nro_factura
      t.string :en_uso
      t.boolean :activo
      t.string :estatus_ejemplar
      t.references :libro
      t.references :libreria

      t.timestamps
    end
    add_index :ejemplares, :libro_id
    add_index :ejemplares, :libreria_id
  end
end
