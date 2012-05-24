class ApplicationController < ActionController::Base
  
  before_filter :authorize

  protect_from_forgery
  include SimpleCaptcha::ControllerHelpers
  
  


  private
  def current_cart
   Cart.find(session[:cart_id])
   rescue ActiveRecord::RecordNotFound
   cart = Cart.create
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


 

 
 	  

end
