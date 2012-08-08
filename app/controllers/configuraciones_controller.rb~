class ConfiguracionesController < ApplicationController
   
  before_filter :es_adminitrador

  layout "administrador"
  add_breadcrumb "Mantenimiento", :ppal_admin_index_path

  def index
	add_breadcrumb "Listado de configuraciones", :configuraciones_path
	@search = Configuracion.search(params[:search])
    @configuraciones = @search.paginate(:page => params[:page], :per_page => 5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @configuraciones }
    end
  end

  # GET /configuraciones/1
  # GET /configuraciones/1.json
  def show
	add_breadcrumb "Datos de la configuración", :configuracion_path
    @configuracion = Configuracion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @configuracion }
    end
  end

  # GET /configuraciones/new
  # GET /configuraciones/new.json
  def new
	add_breadcrumb "Nueva configuración", :new_configuracion_path
    @configuracion = Configuracion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @configuracion }
    end
  end

  # GET /configuraciones/1/edit
  def edit
	add_breadcrumb "Editar configuración", :edit_configuracion_path
    @configuracion = Configuracion.find(params[:id])
  end

  # POST /configuraciones
  # POST /configuraciones.json
  def create
    @configuracion = Configuracion.new(params[:configuracion])
	
    respond_to do |format|
		if 	es_valida(@configuracion) == 1
		  if @configuracion.save
		    format.html { redirect_to @configuracion, :notice => 'Configuracion was successfully created.' }
		    format.json { render :json => @configuracion, :status => :created, :location => @configuracion }
		  else
		    format.html { render :action => "new" }
		    format.json { render :json => @configuracion.errors, :status => :unprocessable_entity }
		  end
		elsif es_valida(@configuracion) == 2
		@configuracion.errors.add(:activa, "Sólo puede haber una configuración activa")
			format.html { render :action => "new" }
		    format.json { render :json => @configuracion.errors, :status => :unprocessable_entity }
		else
			@configuracion.errors.add(:fechas, "Las fechas se solapan con otra configuración existente")
			format.html { render :action => "new" }
		    format.json { render :json => @configuracion.errors, :status => :unprocessable_entity }
			
		end
    end
  end

  # PUT /configuraciones/1
  # PUT /configuraciones/1.json
  def update
    @configuracion = Configuracion.find(params[:id])

    respond_to do |format|
		if 	es_valida(params[:configuracion]) == 1			
		  if @configuracion.update_attributes(params[:configuracion])
		    format.html { redirect_to @configuracion, :notice => 'Configuracion was successfully updated.' }
		    format.json { head :ok }
		  else
		    format.html { render :action => "edit" }
		    format.json { render :json => @configuracion.errors, :status => :unprocessable_entity }
		  end
		elsif es_valida(@configuracion) == 2
		@configuracion.errors.add(:activa, "Sólo puede haber una configuración activa")
			format.html { render :action => "edit" }
		    format.json { render :json => @configuracion.errors, :status => :unprocessable_entity }
		else
			@configuracion.errors.add(:fechas, "Las fechas se solapan con otra configuración existente")
			format.html { render :action => "edit" }
		    format.json { render :json => @configuracion.errors, :status => :unprocessable_entity }
			
		end
		
    end
  end

  # DELETE /configuraciones/1
  # DELETE /configuraciones/1.json
  def destroy
    @configuracion = Configuracion.find(params[:id])
    @configuracion.destroy

    respond_to do |format|
      format.html { redirect_to configuraciones_url }
      format.json { head :ok }
    end
  end

	
  #return 1: la configuracion es valida
  #return 2: ya existe una configuración activa
  #return 3: configuración solapada
  def es_valida(config)
	@temp = Configuracion.where( :activo => true)
	if((@temp[0].id != config.id) and (config.activo))
		return 2			
	end	
	

	print("_____________*****************____temp_______ #{@temp[0].id}____config__#{config.activo}__#{config.id}  "  )	

	@temp=nil

    @temp = Configuracion.where('((:tiempo1 >= fecha_inicio and  :tiempo1  <= fecha_fin) or (:tiempo2 >= fecha_inicio and  :tiempo2  <= fecha_fin)) and id <> :id  )  ', {:tiempo1 => config.fecha_inicio, :tiempo2 => config.fecha_fin,:id =>config.id } )
# 	print("_____________*****************____temp_______ #{@temp[0].id}____config__#{config.id}  "  )	
	if @temp.nil? 	
		return 1
	else	
		return 3
	end
			
  end

	
end
