class PpalAdminController < ApplicationController
  #before_filter :verificar_usuario 

  layout "administrador"
  add_breadcrumb "Inicio", :ppal_admin_index_path
  def index
  end


=begin  
	protected
	def verificar_usuario
		usuario = Usuario.find_by_id(session[:usuario_id])
			if usuario.rol == 'Administrador' 
				return true
			elsif usuario.rol == 'Estudiante' 
				return false	
					
			end 
		
	end
=end

end
