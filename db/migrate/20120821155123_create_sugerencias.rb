class CreateSugerencias < ActiveRecord::Migration
  def change
    create_table :sugerencias do |t|
      t.date :fecha
      t.references :usuario
      t.references :libro

      t.timestamps
    end
    add_index :sugerencias, :usuario_id
    add_index :sugerencias, :libro_id
  end
end
