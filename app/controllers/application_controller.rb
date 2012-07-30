class ApplicationController < ActionController::Base
  
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

	  

end
