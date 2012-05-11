class CreateDependencias < ActiveRecord::Migration
  def change
    create_table :dependencias do |t|
      t.string :nombre
      t.string :tipo_dependencia

      t.timestamps
    end
  end
end
