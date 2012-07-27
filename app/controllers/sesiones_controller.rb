class SesionesController < ApplicationController
  skip_before_filter :authorize


  def nuevo
  end

  def crear
	usuario = Usuario.find_by_cedula(params[:cedula])
	if simple_captcha_valid?  

		if usuario and usuario.authenticate(params[:password])
			session[:usuario_id] = usuario.id
			session[:usuario_nombre] = usuario.nombre
			if usuario.rol == 'Administrador'
				redirect_to ppal_admin_index_url
			elsif usuario.rol == 'Operador'
					redirect_to ppal_admin_url
			else
					redirect_to ppal_estudiante_index_url
			end
		else
			redirect_to inicio_index_url, :alert => "Combinación de Usuario/clave inválido(a)"
		end

	else
		redirect_to inicio_index_url, :alert => "Texto de la imágen Inválido"
	end

  end

  def eliminar
	session[:usuario_id] = nil
	redirect_to inicio_index_url

  end

end
