class CreateConfiguraciones < ActiveRecord::Migration
  def change
    create_table :configuraciones do |t|
      t.integer :periodo
      t.integer :ano
      t.date :fecha_inicio
      t.date :fecha_fin
      t.integer :max_num_libro
      t.boolean :libro_repetido
      t.integer :tiempo_prealquiler
      t.string :tipo_periodo

      t.timestamps
    end
  end
end
