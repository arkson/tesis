class CreateSolvencias < ActiveRecord::Migration
  def change
    create_table :solvencias do |t|
      t.string :estatus
      t.references :usuario
      t.string :tipo_solvencia

      t.timestamps
    end
    add_index :solvencias, :usuario_id
  end
end
