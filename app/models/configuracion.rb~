class Configuracion < ActiveRecord::Base
	has_many :alquiler

     validates :max_num_libro, :numericality => {:greater_than_or_equal_to  => 0}
     validates :tiempo_prealquiler, :numericality => {:greater_than_or_equal_to => 0}  
     validates :ano, :numericality => {:greater_than_or_equal_to => 2012}

	before_destroy :ensure_not_referenced_by_any_alquler


  def ensure_not_referenced_by_any_alquler
	if alauiler.empty?
		return true
	else
		errors.add(:base, 'Alquiler present')
		return false
	end
  end
	

     
end
