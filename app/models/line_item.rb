class LineItem < ActiveRecord::Base
  belongs_to :ejemplar
  belongs_to :cart
  belongs_to :alquiler
  def total_price
	ejemplar.costo_alquiler * quantity
  end


end