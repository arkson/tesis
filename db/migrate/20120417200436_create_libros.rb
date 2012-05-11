class CreateLibros < ActiveRecord::Migration
  def change
    create_table :libros do |t|
      t.string :cota
      t.string :titulo
      t.string :autor
      t.has_attached_file :imagen
      t.integer :edicion
      t.string :lugar_impresion
      t.integer :ano
      t.string :isbn
      t.references :editorial
      t.references :area_conocimiento
      t.references :dependencia

      t.timestamps
    end
    add_index :libros, :editorial_id
    add_index :libros, :area_conocimiento_id
    add_index :libros, :dependencia_id
  end
end
