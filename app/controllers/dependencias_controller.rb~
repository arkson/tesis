class DependenciasController < ApplicationController
  
  layout "administrador"

  # GET /dependencias
  # GET /dependencias.json
  def index
    @dependencias = Dependencia.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @dependencias }
    end
  end

  # GET /dependencias/1
  # GET /dependencias/1.json
  def show
    @dependencia = Dependencia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @dependencia }
    end
  end

  # GET /dependencias/new
  # GET /dependencias/new.json
  def new
    @dependencia = Dependencia.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @dependencia }
    end
  end

  # GET /dependencias/1/edit
  def edit
    @dependencia = Dependencia.find(params[:id])
  end

  # POST /dependencias
  # POST /dependencias.json
  def create
    @dependencia = Dependencia.new(params[:dependencia])

    respond_to do |format|
      if @dependencia.save
        format.html { redirect_to @dependencia, :notice => 'Dependencia was successfully created.' }
        format.json { render :json => @dependencia, :status => :created, :location => @dependencia }
      else
        format.html { render :action => "new" }
        format.json { render :json => @dependencia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /dependencias/1
  # PUT /dependencias/1.json
  def update
    @dependencia = Dependencia.find(params[:id])

    respond_to do |format|
      if @dependencia.update_attributes(params[:dependencia])
        format.html { redirect_to @dependencia, :notice => 'Dependencia was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @dependencia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /dependencias/1
  # DELETE /dependencias/1.json
  def destroy
    @dependencia = Dependencia.find(params[:id])
    @dependencia.destroy

    respond_to do |format|
      format.html { redirect_to dependencias_url }
      format.json { head :ok }
    end
  end
end
