class DonacionesController < ApplicationController

  before_filter :es_adminitrador

  layout "administrador"


  # GET /donaciones
  # GET /donaciones.json
  def index
    @donaciones = Donacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @donaciones }
    end
  end

  # GET /donaciones/1
  # GET /donaciones/1.json
  def show
    @donacion = Donacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @donacion }
    end
  end

  # GET /donaciones/new
  # GET /donaciones/new.json
  def new
    @donacion = Donacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @donacion }
    end
  end

  # GET /donaciones/1/edit
  def edit
    @donacion = Donacion.find(params[:id])
  end

  # POST /donaciones
  # POST /donaciones.json
  def create
    @donacion = Donacion.new(params[:donacion])

    respond_to do |format|
      if @donacion.save
        format.html { redirect_to @donacion, :notice => 'Donacion was successfully created.' }
        format.json { render :json => @donacion, :status => :created, :location => @donacion }
      else
        format.html { render :action => "new" }
        format.json { render :json => @donacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /donaciones/1
  # PUT /donaciones/1.json
  def update
    @donacion = Donacion.find(params[:id])

    respond_to do |format|
      if @donacion.update_attributes(params[:donacion])
        format.html { redirect_to @donacion, :notice => 'Donacion was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @donacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /donaciones/1
  # DELETE /donaciones/1.json
  def destroy
    @donacion = Donacion.find(params[:id])
    @donacion.destroy

    respond_to do |format|
      format.html { redirect_to donaciones_url }
      format.json { head :ok }
    end
  end


  def buscar_usuario
	@usuario = Usuario.find_by_cedula(params[:cedula])
    print("asaaddddddddddddddddddddddddd")
    respond_to do |format|
      #format.html { redirect_to ppal_estudiante_index_path}
	 format.js 
	 #format.json { render format.json , :status => :created, :location => @lin_items }
    end

  end



end
