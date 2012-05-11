class CreateNoticias < ActiveRecord::Migration
  def change
    create_table :noticias do |t|
      t.string :titulo
	  t.has_attached_file :imagen	
      t.text :contenido
      t.string :tipo_contenido
      t.date :fecha

      t.timestamps
    end
  end
end
