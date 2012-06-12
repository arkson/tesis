class EjemplaresController < ApplicationController
  
  before_filter :es_adminitrador

  layout "administrador"
	add_breadcrumb "Inicio", :ppal_admin_index_path
  # GET /ejemplares
  # GET /ejemplares.json
  def index
	add_breadcrumb "ejemplares", ejemplares_index_path 
	@search = Ejemplar.search(params[:search])
    @ejemplares = @search.paginate(:page => params[:page], :per_page => 5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @ejemplares }
    end
  end

  # GET /ejemplares/1
  # GET /ejemplares/1.json
  def show
    @ejemplar = Ejemplar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @ejemplar }
    end
  end

  # GET /ejemplares/new
  # GET /ejemplares/new.json
  def new
    @ejemplar = Ejemplar.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @ejemplar }
    end
  end

  # GET /ejemplares/1/edit
  def edit
    @ejemplar = Ejemplar.find(params[:id])
  end

  # POST /ejemplares
  # POST /ejemplares.json
  def create
    @ejemplar = Ejemplar.new(params[:ejemplar])

    respond_to do |format|
      if @ejemplar.save
        format.html { redirect_to @ejemplar, :notice => 'Ejemplar was successfully created.' }
        format.json { render :json => @ejemplar, :status => :created, :location => @ejemplar }
      else
        format.html { render :action => "new" }
        format.json { render :json => @ejemplar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ejemplares/1
  # PUT /ejemplares/1.json
  def update
    @ejemplar = Ejemplar.find(params[:id])

    respond_to do |format|
      if @ejemplar.update_attributes(params[:ejemplar])
        format.html { redirect_to @ejemplar, :notice => 'Ejemplar was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @ejemplar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ejemplares/1
  # DELETE /ejemplares/1.json
  def destroy
    @ejemplar = Ejemplar.find(params[:id])
    @ejemplar.destroy

    respond_to do |format|
      format.html { redirect_to ejemplares_url }
      format.json { head :ok }
    end
  end
end
