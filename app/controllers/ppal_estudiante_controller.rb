class PpalEstudianteController < ApplicationController
  layout "estudiante"
  add_breadcrumb "Inicio", :ppal_estudiante_index_path

  def index
	
    @search = Ejemplar.order(:costo_alquiler) 
	@ejemplares =  @search.paginate(:page => params[:page], :per_page =>5)
	@cart = current_cart 
	@configuracion = current_config

  end

end
