class Ejemplar < ActiveRecord::Base
  belongs_to :libro
  belongs_to :libreria
  has_many :line_item

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :numero_ejemplar, :libro, :tipo_adquisicion, :costo_alquiler, :presence => true
  #validates :cota, :uniqueness => true
  
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
     [libro.cota,numero_ejemplar].join('.')
  end


 def ensure_not_referenced_by_any_line_item
	if line_item.empty?
		return true
	else
		errors.add(:base, 'Line Items present')
		return false
	end
 end

end
