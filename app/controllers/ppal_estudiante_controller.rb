class PpalEstudianteController < ApplicationController
  before_filter :es_estudiante
  layout "estudiante"
  add_breadcrumb "Inicio", :ppal_estudiante_index_path
  
  

  def index
 	add_breadcrumb "Catálogo de libros", ppal_estudiante_index_path
	@query = Ejemplar.where("estatus_ejemplar = 'Disponible' or estatus_ejemplar = 'Solicitado' ") 
	@search = @query.search(params[:search])
	@ejemplares =  @search.paginate(:page => params[:page], :per_page =>5)
	@cart = current_cart 
	@configuracion = current_config

  end


  def ver_alquiler
	add_breadcrumb "Alquileres realizados", :ppal_estudiante_ver_alquiler_path
	@alquileres = Alquiler.where(:usuario_id => session[:usuario_id])
	@cart = current_cart 

  end


  def ver_datos 
	add_breadcrumb "Ver datos", :ppal_estudiante_ver_datos_path
    @alquiler = Alquiler.find(params[:id])
	@cart = current_cart 

   
  end

  def confirmar_alquiler 
	
    @alquiler = Alquiler.new
	 @config = current_config	
    @cart = current_cart
    if @cart.line_item.empty?
		 redirect_to store_url, :notice => "Debe seleccionar al menos un libro"
		 return
	 end
	@alquiler.add_line_items_from_cart(current_cart)
	@alquiler.estatus = 'Prealquilado'
	@alquiler.fecha_fin = @config[0].fecha_fin
   	@alquiler.usuario = Usuario.find(session[:usuario_id])
	

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @alquiler }
    end
  
   
  end


	



end
