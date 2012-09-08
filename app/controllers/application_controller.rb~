require 'monitor'

class ApplicationController < ActionController::Base
  attr_reader :ejemplar

  before_filter :authorize, :set_timezone 	
  before_filter :set_i18n_locale_from_params	

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

  public
  def categorias

	@query = Libro.where("area_conocimiento_id = 1").count
	@query2 = Libro.where("area_conocimiento_id = 2").count
	@query3 = Libro.where("area_conocimiento_id = 3").count
	@query4 = Libro.where("area_conocimiento_id = 4").count
	@query5 = Libro.where("area_conocimiento_id = 5").count

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



  def guardar_log(usuario_id, controlador, accion, estado_anterior, estado_posterior)	
	begin
	
		#< br/>.		<%= simple_format auto_link sanitize comentario.texto_completo %>
		@auditoria = Auditoria.new	
		@auditoria.usuario_id = usuario_id
		@auditoria.controlador = controlador
		@auditoria.accion = accion


		@auditoria.estado_anterior = ""
		estado_anterior.attributes.each do |attr|
			@auditoria.estado_anterior = @auditoria.estado_anterior + attr[0].to_s + ": " + attr[1].to_s + " \n " 				
		end

		@auditoria.estado_posterior = ""
		if estado_posterior.nil?
			@auditoria.estado_posterior = ""
		else
			@auditoria.estado_posterior = ""
			estado_posterior.attributes.each do |attr| 
				@auditoria.estado_posterior = @auditoria.estado_posterior + attr[0].to_s + ": " + attr[1].to_s + " \n "
			end
		end

		@auditoria.save
	rescue Exception => exc

		print "____________________________#{exc.message}" 
	
	end	
  end


  def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.include?(params[:locale].to_sym)
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = 
            "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
   end

   def default_url_options
      { :locale => I18n.locale }
   end


  def top_10
		@config = current_config 
 		@top_libros = Libro.find_by_sql(['select count(e.id) as cantidad, b.id, b.titulo,b.cota
											from alquileres a join lines_items l on (a.id = l.alquiler_id)
											join devoluciones d on (l.id = d.line_item_id)
											join ejemplares e on (l.ejemplar_id = e.id)
											join libros b on (e.libro_id = b.id) 
											where (a.estatus = ? or a.estatus = ?)
											and a.configuracion_id = ?
											group by b.id
											order by cantidad desc
											LIMIT 10 ', "Alquilado", "Alquiler Finalizado", @config[0].id ])

  end	

  def total_recaudado
	@config = current_config 
	@total = Alquiler.find_by_sql(['select sum(e.costo_alquiler) as total
										from alquileres a join lines_items l on (a.id = l.alquiler_id)
										join ejemplares e on (l.ejemplar_id = e.id)
										where (a.estatus = ? or a.estatus = ?)
										and a.configuracion_id = ?',"Alquilado", "Alquiler Finalizado", @config[0].id ])

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

