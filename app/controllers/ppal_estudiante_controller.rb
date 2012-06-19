class PpalEstudianteController < ApplicationController
  before_filter :es_estudiante
  layout "estudiante"
  add_breadcrumb "Inicio", :ppal_estudiante_index_path

  def index
	#estatus = 'Disponible'
	#@search = Ejemplar.joins('LEFT OUTER JOIN lines_items ON lines_items.ejemplar_id = ejemplares.id').where('estatus_ejemplar = :estatus1',{:estatus1 => estatus}) 
    #@search = Ejemplar.order(:costo_alquiler) 
	@query = Ejemplar.where("estatus_ejemplar = 'Disponible' or estatus_ejemplar = 'Solicitado' ") 
	@search = @query.search(params[:search])
	@ejemplares =  @search.paginate(:page => params[:page], :per_page =>5)
	@cart = current_cart 
	@configuracion = current_config

  end


  def ver_alquiler
	@alquileres = Alquiler.where(:usuario_id => session[:usuario_id])
	@cart = current_cart 
  end



end
