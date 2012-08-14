class CreateAuditorias < ActiveRecord::Migration
  def change
    create_table :auditorias do |t|
      t.references :usuario
      t.string :controlador
      t.string :accion
      t.text :estado_anterior
      t.text :estado_posterior

      t.timestamps
    end
    add_index :auditorias, :usuario_id
  end
end
