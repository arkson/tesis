class CreateLibrerias < ActiveRecord::Migration
  def change
    create_table :librerias do |t|
      t.string :nombre
      t.string :telefono

      t.timestamps
    end
  end
end
