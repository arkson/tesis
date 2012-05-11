class Cart < ActiveRecord::Base

	has_many :line_item, :dependent => :destroy

	def add_ejemplar(ejemplar_id, repetido)
	 
	 current_item = line_item.find_by_ejemplar_id(ejemplar_id)
	      	
		 if current_item
			if repetido==true 
		 		current_item.quantity += 1
			end
		 else
	 	 	current_item = line_item.build(:ejemplar_id => ejemplar_id,:quantity => 1 )
		 end

	 current_item
   	end

	def total_price
		line_item.to_a.sum { |item| item.total_price }
	end

   def total_ejemplares 
	
		line_item.sum(:quantity)	 	

   end	


end
