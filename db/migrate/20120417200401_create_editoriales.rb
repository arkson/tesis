class CreateEditoriales < ActiveRecord::Migration
  def change
    create_table :editoriales do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
