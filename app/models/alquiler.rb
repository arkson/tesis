class Alquiler < ActiveRecord::Base
  has_many :line_item
  has_many :devolucion
  belongs_to :usuario
  belongs_to :configuracion

def add_line_items_from_cart(cart )
	
	cart.line_item.each do |item|
		line_item << item
		#item.ejemplar.estatus_ejemplar = 'prealquilado'  
	end
		
end




def limpiar_items_cart(cart)

	cart.line_item.each do |item|
		line_item << item
		#item.ejemplar.estatus_ejemplar = 'prealquilado'
		item.cart_id = nil
	end

end

def total_price
	line_item.to_a.sum { |item| item.total_price }
end



def total_libros
	
	line_item.to_a.count
	

end	



end
