class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nombre
      t.string :cedula
      t.string :password_digest
      t.string :correo
      t.integer :unid_creditos
      t.references :dependencia

      t.timestamps
    end
    add_index :usuarios, :dependencia_id
  end
end
