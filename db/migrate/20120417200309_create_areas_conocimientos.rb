class CreateAreasConocimientos < ActiveRecord::Migration
  def change
    create_table :areas_conocimientos do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
