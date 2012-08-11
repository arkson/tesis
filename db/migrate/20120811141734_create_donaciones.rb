class CreateDonaciones < ActiveRecord::Migration
  def change
    create_table :donaciones do |t|
      t.references :ejemplar
      t.references :usuario

      t.timestamps
    end
    add_index :donaciones, :ejemplar_id
    add_index :donaciones, :usuario_id
  end
end
