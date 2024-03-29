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
   @ejem = get_proximo_ejemplar(params[:libro_id])
   if !@ejem.nil? 	
	   @libro  = @ejem.libro		 	
	   @cont = params[:cont]
	   
	   @alq = Alquiler.joins(:line_item => :ejemplar).where( "estatus_ejemplar = 'Alquilado' or estatus_ejemplar = 'Prealquilado' "  )
	   var = 0

	   if (!@alq.empty?)
		var = @alq[0].total_libros	
	   end

			 
		
	   if (@cart.total_ejemplares +  var)  < @config[0].max_num_libro   
	#		if !(@ejem.estatus_ejemplar == 'Solicitado')    
	#			@ejem.estatus_ejemplar = 'Solicitado'
				@lin_items = @cart.add_ejemplar(@ejem.id, @config[0].libro_repetido )
				  	respond_to do |format|
					  if @lin_items.save and @ejem.save
						 guardar_log(session[:usuario_id], self.class.name,__method__.to_s, @temp,nil )	
						 format.html { redirect_to ppal_estudiante_index_path}
						 format.js { @current_item = @lin_items, libro = @libro }
						 format.json { render format.json , :status => :created, :location => @lin_items }
						else
						 format.html { render :action => "new" }
						 format.json { render :json => @lin_items.errors, :status => :unprocessable_entity }
						end
					 end
	#		else
	#			redirect_to ppal_estudiante_index_url, :alert => "El ejemplar ya ha sido seleccionado, puede intentar más tarde, en caso de que haya sido liberado"
	#		end 
		else

			
			redirect_to ppal_estudiante_index_url, :notice => "Ha excedido el número máximo de ejemplares"
			

	   end	
	else	
#		respond_to do |format|
#		 flash.now[:error]="ASJASDA"
#		 format.html { render :nothing => true }
#		 format.js
#		end
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
	alquiler_id = @lin_items.alquiler_id
    @lin_items.destroy
    respond_to do |format|
      format.html { redirect_to :controller => 'ppal_estudiante',:action=>"confirmar_alquiler", :id=>alquiler_id}
      format.json { head :ok }
    end
  end

  	
end
