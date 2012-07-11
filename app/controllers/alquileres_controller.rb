class AlquileresController < ApplicationController

  layout "administrador"

 
  add_breadcrumb "Inicio", :alquileres_path


  def index
    # @alquileres = Alquiler.all
	@search = Alquiler.search(params[:search])
    @alquileres = @search.paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @alquileres }
    end
  end

  # GET /alquileres/1
  # GET /alquileres/1.json
  def show
    @alquiler = Alquiler.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @alquiler }
    end
  end

  # GET /alquileres/new
  # GET /alquileres/new.json
  def new
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

  # GET /alquileres/1/edit
  def edit
    @alquiler = Alquiler.find(params[:id])
  end


  

  # POST /alquileres
  # POST /alquileres.json
  def create 	
    #@alquiler = Alquiler.new(params[:alquiler])
	 @alquiler = Alquiler.new
	 @config = current_config
	 @alquiler.configuracion_id = @config[0].id
	 
	 @alquiler.limpiar_items_cart(current_cart)	
	 @alquiler.estatus = 'Prealquilado'
	 @alquiler.fecha_fin = @config[0].fecha_fin
    @alquiler.usuario = Usuario.find(session[:usuario_id])
	

	@alquiler.line_item.each do |item|
		@ejem = Ejemplar.find(item.ejemplar_id)
		@ejem.estatus_ejemplar = 'Prealquilado'	
		@ejem.save
	end	
		
  respond_to do |format|
      if @alquiler.save
		  
		  Cart.destroy(session[:cart_id])
		  session[:cart_id] = nil
		  @alquiler.line_item.each do |item|
				@devolucion = Devolucion.new
				@devolucion.alquiler_id = @alquiler.id
				@devolucion.estatus = "Sin retirar"
				@devolucion.line_item_id = item.id
				@devolucion.save	
		end	
        format.html { redirect_to ppal_estudiante_index_path, :notice => 'Tu alquiler se ha realizado con éxito.' }
        format.json { render :json => @alquiler, :status => :created, :location => @alquiler }
			  		
		
      else
        format.html { render :action => "new" }
        format.json { render :json => @alquiler.errors, :status => :unprocessable_entity }
      end
    end




  end

  # PUT /alquileres/1
  # PUT /alquileres/1.json
  def update
    @alquiler = Alquiler.find(params[:id])
	@alquiler.estatus = "Alquilado" 

    @alquiler.devolucion.each do |dev|
		@devolucion = Devolucion.find(dev.id) 	
		@devolucion.estatus = "Sin entregar"
		@devolucion.save 
	end

	@alquiler.line_item.each do |item|
		@ejem = Ejemplar.find(item.ejemplar_id)
		@ejem.estatus_ejemplar = 'Alquilado'	
		@ejem.save
	end		

    respond_to do |format|
      if @alquiler.update_attributes(params[:alquiler])


        format.html {redirect_to :action => "edit", :id => @alquiler.id, :notice => 'Alquiler actualizado exitosamente.'}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @alquiler.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /alquileres/1
  # DELETE /alquileres/1.json
  def destroy
    @alquiler = Alquiler.find(params[:id])
    @alquiler.destroy

    respond_to do |format|
      format.html { redirect_to alquileres_url }
      format.json { head :ok }
    end
  end




end
