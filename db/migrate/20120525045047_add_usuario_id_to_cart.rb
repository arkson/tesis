class AddUsuarioIdToCart < ActiveRecord::Migration
  def change
    add_column :carts, :usuario_id, :integer
  end
end
