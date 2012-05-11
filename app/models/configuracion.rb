class Configuracion < ActiveRecord::Base


     validates :max_num_libro, :numericality => {:greater_than_or_equal_to  => 0}
     validates :tiempo_prealquiler, :numericality => {:greater_than_or_equal_to => 0}  
     validates :ano, :numericality => {:greater_than_or_equal_to => 2012}
     
end
