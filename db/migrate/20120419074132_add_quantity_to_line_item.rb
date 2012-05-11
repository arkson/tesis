class AddQuantityToLineItem < ActiveRecord::Migration
  def change
    add_column :lines_items, :quantity, :integer, :default => 1
  end
end
