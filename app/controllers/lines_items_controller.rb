class LinesItemsController < ApplicationController

  skip_before_filter :authorize, :only => :create

  # GET /lines_items
  # GET /lines_items.json
  def index
    @lines_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @lines_items }
    end
  end

  # GET /lines_items/1
  # GET /lines_items/1.json
  def show
    @lin_items = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @lin_items }
    end
  end

  # GET /lines_items/new
  # GET /lines_items/new.json
  def new
    @lin_items = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @lin_items }
    end
  end

  # GET /lines_items/1/edit
  def edit
    @lin_items = LineItem.find(params[:id])
  end

  # POST /lines_items
  # POST /lines_items.json
  

  def create
   @config = current_config
   @cart = current_cart
 	@ejem = Ejemplar.find(params[:ejemplar_id])
		 	
   @alq = Alquiler.where(:usuario_id => session[:usuario_id])	
	#+ @alq.total_ejemplares(session[:usuario_id]) 
   if @cart.total_ejemplares < @config[0].max_num_libro   
		if !(@ejem.estatus_ejemplar == 'Solicitado')    
			@ejem.estatus_ejemplar = 'Solicitado'
			@lin_items = @cart.add_ejemplar(@ejem.id, @config[0].libro_repetido )
			  	respond_to do |format|
				  if @lin_items.save and @ejem.save
					 format.html { redirect_to ppal_estudiante_index_path}
					 format.js { @current_item = @lin_items }
					 format.json { render :json => @lin_items, :status => :created, :location => @lin_items }
					else
					 format.html { render :action => "new" }
					 format.json { render :json => @lin_items.errors, :status => :unprocessable_entity }
					end
				 end
		else
			redirect_to ppal_estudiante_index_url, :alert => "El ejemplar ya ha sido seleccionado, puede intentar más tarde, en caso de que haya sido liberado"
		end 
	else
		redirect_to ppal_estudiante_index_url, :alert => "Ha excedido el número máximo de ejemplares"
		

   end	


  end


  # PUT /lines_items/1
  # PUT /lines_items/1.json
  def update
    @lin_items = LineItem.find(params[:id])

    respond_to do |format|
      if @lin_items.update_attributes(params[:lin_items])
        format.html { redirect_to @lin_items, :notice => 'Line item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @lin_items.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lines_items/1
  # DELETE /lines_items/1.json
  def destroy
    @lin_items = LineItem.find(params[:id])
    @lin_items.destroy

    respond_to do |format|
      format.html { redirect_to lines_items_url }
      format.json { head :ok }
    end
  end
end
