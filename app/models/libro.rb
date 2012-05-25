class Libro < ActiveRecord::Base
  belongs_to :editorial
  belongs_to :area_conocimiento
  belongs_to :dependencia
  has_many :ejemplar
  
 
  
  before_destroy :ensure_not_referenced_by_any_line_item


  validates :cota, :titulo, :autor,:edicion, :ano, :presence => true  
  validates :cota, :isbn,  :uniqueness => true

  has_attached_file :imagen, :styles => { :medium => "300x300>", :thumb => "60x60>" }

  def titulo_and_autor
  	[titulo,autor].join(' | ')
  end


 def ensure_not_referenced_by_any_line_item
	if line_items.empty?
		return true
	else
		errors.add(:base, 'Line Items present')
		return false
	end
 end


end
