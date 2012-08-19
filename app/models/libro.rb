
class Libro < ActiveRecord::Base
  belongs_to :editorial
  belongs_to :area_conocimiento
  belongs_to :dependencia
  has_many :ejemplar 
  
 
  attr_accessor :libro_titulo
  

  validates :cota, :titulo, :autor,:edicion, :ano, :presence => true  
  validates :cota, :isbn,  :uniqueness => true

  has_attached_file :imagen, :styles => { :medium => "300x300>", :thumb => "60x60>" }

  def titulo_and_autor
  	[titulo,autor].join(' | ')
  end
  public 

  public
  def cantidad_disponible
    ejemplar.where("estatus_ejemplar = 'Disponible' ").count      
		  		
  end

 def precio_minimo 	
	ejemplar.where("estatus_ejemplar = 'Disponible' or estatus_ejemplar = 'Solicitado'").order('costo_alquiler asc').first.costo_alquiler 

 end 	
 	
 def precio_maximo
	ejemplar.where("estatus_ejemplar = 'Disponible' or estatus_ejemplar = 'Solicitado'").order('costo_alquiler asc').last.costo_alquiler 
 end


end


