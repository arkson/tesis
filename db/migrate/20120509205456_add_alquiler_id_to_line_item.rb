class AddAlquilerIdToLineItem < ActiveRecord::Migration
  def change
    add_column :lines_items, :alquiler_id, :integer
  end
end
