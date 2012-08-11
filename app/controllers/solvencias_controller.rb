class SolvenciasController < ApplicationController
   before_filter :es_adminitrador
   layout "administrador"

  # GET /solvencias
  # GET /solvencias.json
  def index
    @search = Solvencia.order('created_at desc').search(params[:search])
	@solvencias = @search.paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @solvencias }
    end
  end

  # GET /solvencias/1
  # GET /solvencias/1.json
  def show
    @solvencia = Solvencia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @solvencia }
    end
  end

  # GET /solvencias/new
  # GET /solvencias/new.json
  def new
    @solvencia = Solvencia.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @solvencia }
    end
  end

  # GET /solvencias/1/edit
  def edit
    @solvencia = Solvencia.find(params[:id])
  end

  # POST /solvencias
  # POST /solvencias.json
  def create
    @solvencia = Solvencia.new(params[:solvencia])

    respond_to do |format|
      if @solvencia.save
        format.html { redirect_to @solvencia, :notice => 'Solvencia was successfully created.' }
        format.json { render :json => @solvencia, :status => :created, :location => @solvencia }
      else
        format.html { render :action => "new" }
        format.json { render :json => @solvencia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /solvencias/1
  # PUT /solvencias/1.json
  def update
    @solvencia = Solvencia.find(params[:id])
	@solvencia.estatus= "Solvencia Entregada"		

    respond_to do |format|
      if @solvencia.update_attributes(params[:solvencia])
        format.html { redirect_to :action => "index" }
        format.json { head :ok }
      else
        format.html { redirect_to  :action => "index", :notice => "No se pudo guardar los cambios, por favor intente más tarde"  }
        format.json { head :ok }

      end
    end
  end

  # DELETE /solvencias/1
  # DELETE /solvencias/1.json
  def destroy
    @solvencia = Solvencia.find(params[:id])
    @solvencia.destroy

    respond_to do |format|
      format.html { redirect_to solvencias_url }
      format.json { head :ok }
    end
  end
end
