class LineItem < ActiveRecord::Base
  belongs_to :ejemplar
  belongs_to :cart
  belongs_to :alquiler
  has_one :devolucion

  def total_price
	ejemplar.costo_alquiler * quantity
  end

  def estatus_devolucion
	if not devolucion.nil?
		devolucion.estatus
	else
		"En proceso"
	end
  end

end
