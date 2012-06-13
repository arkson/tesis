class DevolucionesController < ApplicationController
  # GET /devoluciones
  # GET /devoluciones.json
  def index
    @devoluciones = Devolucion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @devoluciones }
    end
  end

  # GET /devoluciones/1
  # GET /devoluciones/1.json
  def show
    @devolucion = Devolucion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @devolucion }
    end
  end

  # GET /devoluciones/new
  # GET /devoluciones/new.json
  def new
    @devolucion = Devolucion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @devolucion }
    end
  end

  # GET /devoluciones/1/edit
  def edit
    @devolucion = Devolucion.find(params[:id])
  end

  # POST /devoluciones
  # POST /devoluciones.json
  def create
    @devolucion = Devolucion.new(params[:devolucion])

    respond_to do |format|
      if @devolucion.save
        format.html { redirect_to @devolucion, :notice => 'Devolucion was successfully created.' }
        format.json { render :json => @devolucion, :status => :created, :location => @devolucion }
      else
        format.html { render :action => "new" }
        format.json { render :json => @devolucion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /devoluciones/1
  # PUT /devoluciones/1.json
  def update
    @devolucion = Devolucion.find(params[:id])

    respond_to do |format|
      if @devolucion.update_attributes(params[:devolucion])
        format.html { redirect_to @devolucion, :notice => 'Devolucion was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @devolucion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /devoluciones/1
  # DELETE /devoluciones/1.json
  def destroy
    @devolucion = Devolucion.find(params[:id])
    @devolucion.destroy

    respond_to do |format|
      format.html { redirect_to devoluciones_url }
      format.json { head :ok }
    end
  end
end
