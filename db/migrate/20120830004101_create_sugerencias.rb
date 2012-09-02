class CreateSugerencias < ActiveRecord::Migration
  def change
    create_table :sugerencias do |t|
      t.string :usuario
      t.text :listado

      t.timestamps
    end
  end
end
