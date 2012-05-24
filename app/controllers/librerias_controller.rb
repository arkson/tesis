class LibreriasController < ApplicationController
  before_filter :es_adminitrador 
  layout "administrador"

  # GET /librerias
  # GET /librerias.json
  def index
    @librerias = Libreria.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @librerias }
    end
  end

  # GET /librerias/1
  # GET /librerias/1.json
  def show
    @libreria = Libreria.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @libreria }
    end
  end

  # GET /librerias/new
  # GET /librerias/new.json
  def new
    @libreria = Libreria.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @libreria }
    end
  end

  # GET /librerias/1/edit
  def edit
    @libreria = Libreria.find(params[:id])
  end

  # POST /librerias
  # POST /librerias.json
  def create
    @libreria = Libreria.new(params[:libreria])

    respond_to do |format|
      if @libreria.save
        format.html { redirect_to @libreria, :notice => 'Libreria was successfully created.' }
        format.json { render :json => @libreria, :status => :created, :location => @libreria }
      else
        format.html { render :action => "new" }
        format.json { render :json => @libreria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /librerias/1
  # PUT /librerias/1.json
  def update
    @libreria = Libreria.find(params[:id])

    respond_to do |format|
      if @libreria.update_attributes(params[:libreria])
        format.html { redirect_to @libreria, :notice => 'Libreria was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @libreria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /librerias/1
  # DELETE /librerias/1.json
  def destroy
    @libreria = Libreria.find(params[:id])
    @libreria.destroy

    respond_to do |format|
      format.html { redirect_to librerias_url }
      format.json { head :ok }
    end
  end
end
