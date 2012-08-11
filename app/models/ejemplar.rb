class Ejemplar < ActiveRecord::Base
  belongs_to :libro
  belongs_to :libreria
  has_many :line_item
  	
  before_destroy :ensure_not_referenced_by_any_line_item
   
  validates :numero_ejemplar, :libro, :tipo_adquisicion, :costo_alquiler, :presence => true
  validates :numero_ejemplar, :numericality => {:greater_than => 0}	
  validates :costo_alquiler, :numericality => {:greater_than => 0}	
 

  attr_accessible :cota
  attr_accessor :cota
 
  
  private
  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
	  if line_item.empty?
	   return true
	  else
	   errors.add(:base, 'Line Items present')
	   return false
	  end
  end
	
  public
  def cota
     @cota = [libro.cota,numero_ejemplar].join('.')
	
  end

  

  def ensure_not_referenced_by_any_line_item
	if line_item.empty?
		return true
	else
		errors.add(:base, 'Line Items present')
		return false
	end
  end

  def alquiler
	if line_item.empty? 
		return nil
	else
		
		return line_item.joins(:devolucion).where(" (devoluciones.estatus ='Sin retirar' or devoluciones.estatus = 'Sin devolver') and lines_items.ejemplar_id = :ejemplar_id   ",{ :ejemplar_id => id })[0].devolucion.alquiler
	end
	
  end


end
