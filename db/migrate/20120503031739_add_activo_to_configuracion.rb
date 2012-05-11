class AddActivoToConfiguracion < ActiveRecord::Migration
  def change
    add_column :configuraciones, :activo, :boolean
  end
end
