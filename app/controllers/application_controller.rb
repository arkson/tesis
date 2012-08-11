require 'monitor'

class ApplicationController < ActionController::Base
  attr_reader :ejemplar
  

  before_filter :authorize, :set_timezone 	

  protect_from_forgery
  include SimpleCaptcha::ControllerHelpers
  
  
  def set_timezone  
	Time.zone = 'America/Caracas'
  end  
  
  


  private
  def current_cart
   cart = Cart.find_by_usuario_id(session[:usuario_id])
   #Cart.find(session[:cart_id])
   #rescue ActiveRecord::RecordNotFound
   #cart = Cart.create
   if cart.nil?
	   cart = Cart.new(:usuario_id => session[:usuario_id]) 
	 
	   cart.save	   		
   end
   session[:cart_id] = cart.id
   cart	 

  end


  protected
	def authorize
		unless Usuario.find_by_id(session[:usuario_id])
		redirect_to inicio_index_path, :notice => "Por Favor Inicie Sesion"
		end
	end


  private
  def current_config
	config = nil
    tiempo = Time.now
    config = Configuracion.where('fecha_inicio  <= :tiempo1 and fecha_fin >= :tiempo2 and activo = true ', {:tiempo1 => tiempo, :tiempo2 => tiempo } ) 		
	
	config
  end


  def es_adminitrador

	usuario = Usuario.find(session[:usuario_id]) 	

	if !(usuario.rol == "Administrador") and (usuario.rol == "Estudiante") 	
		redirect_to ppal_estudiante_index_path  
	end

  end

  
  def es_estudiante

	usuario = Usuario.find(session[:usuario_id]) 	

	if !(usuario.rol == "Estudiante") and (usuario.rol == "Administrador")	
		redirect_to ppal_admin_index_path  
	end

  end
 

  public
  def get_imagen 
    imagen = "" 
	if isbn != nil 
		@books = GoogleBooks.search('isbn:8429146083')
		imagen = @books.first.image_link 
 	end
	imagen 
  end	


#  public
#  def get_proximo_ejemplar(libro_id)
#		libro = Libro.find(libro_id)
#		       
#		if(libro.cantidad_disponible >= 1)
#			synchronize do
#				@ejemplar = libro.ejemplar.where(:estatus_ejemplar =>'Disponible').first				
#				@ejemplar.estatus_ejemplar = "Solicitado"
#				@ejemplar.save
#				return @ejemplar
#			end			
#		else
#			redirect_to ppal_estudiante_index_path, :notice => "Los ejemplares estan agotados"} 
#			return nil
#		end
#		
#  end	


  def get_proximo_ejemplar(libro_id)		
	libro = Libro.find(libro_id)
	m = Observar.get_proximo_ejemplar(libro)  
    
  end


  def es_solvente(usuario_id)
		@configuracion = current_config
		 	
		@coleccion = Usuario.find_by_sql(['select distinct (u.cedula ), u.nombre, u.dependencia_id
											from usuarios u join alquileres a on (u.id = a.usuario_id)
											join devoluciones d  on (a.id = d.alquiler_id) 
											join configuraciones c on (c.id = a.configuracion_id  )
											where d.estatus = "Sin devolver"
											and ((c.ano <= ? and c.periodo < ?) or (c.ano < ?)) 
											and u.id = ? order by u.dependencia_id, u.cedula asc ',@configuracion[0].ano,@configuracion[0].periodo, @configuracion[0].ano, usuario_id])	
	if @coleccion.count ==0  
		return true
	else
		return false
	end		

  end	

end


class Observar < Monitor
	attr_reader :ejemplar
    

  public
  def self.get_proximo_ejemplar(libro)
		
			mutex = Mutex.new 	
        
			if(libro.cantidad_disponible >= 1)
				mutex.synchronize do
					@ejemplar = libro.ejemplar.where(:estatus_ejemplar =>'Disponible').first				
					@ejemplar.estatus_ejemplar = "Solicitado"
					@ejemplar.save
					return @ejemplar
				end			
			else 
				
				return nil
			end
		
  end		  
  

end 

