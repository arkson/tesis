class AddConfiguracionIdToAlquiler < ActiveRecord::Migration
  def change
    add_column :alquileres, :configuracion_id, :integer
  end
end
