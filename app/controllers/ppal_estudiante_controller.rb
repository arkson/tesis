class PpalEstudianteController < ApplicationController
  layout "estudiante"
  add_breadcrumb "Inicio", :ppal_estudiante_index_path

  def index
	#estatus = 'Disponible'
	#@search = Ejemplar.joins('LEFT OUTER JOIN lines_items ON lines_items.ejemplar_id = ejemplares.id').where('estatus_ejemplar = :estatus1',{:estatus1 => estatus}) 
    #@search = Ejemplar.order(:costo_alquiler) 
	@search = Ejemplar.where("estatus_ejemplar = 'Disponible' or estatus_ejemplar = 'Solicitado' ") 
	@ejemplares =  @search.paginate(:page => params[:page], :per_page =>5)
	@cart = current_cart 
	@configuracion = current_config

  end

end
