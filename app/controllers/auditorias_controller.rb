class AuditoriasController < ApplicationController

  before_filter :es_adminitrador
  layout "administrador"
	
  add_breadcrumb "listado de auditorías", :auditorias_path	
  # GET /auditorias
  # GET /auditorias.json
  def index
   
	@search = Auditoria.order('id desc').search(params[:search])
    @auditorias = @search.paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @auditorias }
    end
  end

  # GET /auditorias/1
  # GET /auditorias/1.json
  def show
    @auditoria = Auditoria.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @auditoria }
    end
  end

  # GET /auditorias/new
  # GET /auditorias/new.json
  def new
    @auditoria = Auditoria.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @auditoria }
    end
  end

  # GET /auditorias/1/edit
  def edit
    @auditoria = Auditoria.find(params[:id])
  end

  # POST /auditorias
  # POST /auditorias.json
  def create
    @auditoria = Auditoria.new(params[:auditoria])

    respond_to do |format|
      if @auditoria.save
        format.html { redirect_to @auditoria, :notice => 'Auditoria was successfully created.' }
        format.json { render :json => @auditoria, :status => :created, :location => @auditoria }
      else
        format.html { render :action => "new" }
        format.json { render :json => @auditoria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /auditorias/1
  # PUT /auditorias/1.json
  def update
    @auditoria = Auditoria.find(params[:id])

    respond_to do |format|
      if @auditoria.update_attributes(params[:auditoria])
        format.html { redirect_to @auditoria, :notice => 'Auditoria was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @auditoria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /auditorias/1
  # DELETE /auditorias/1.json
  def destroy
    @auditoria = Auditoria.find(params[:id])
    @auditoria.destroy

    respond_to do |format|
      format.html { redirect_to auditorias_url }
      format.json { head :ok }
    end
  end
end
