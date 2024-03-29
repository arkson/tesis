class DependenciasController < ApplicationController
   
  before_filter :es_adminitrador

  layout "administrador"
  add_breadcrumb "Mantenimiento", :ppal_admin_index_path
  # GET /dependencias
  # GET /dependencias.json
  def index

	add_breadcrumb "Listado de dependencias", :dependencias_index_path
	@search = Dependencia.search(params[:search])
    @dependencias = @search.paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @dependencias }
    end
  end

  # GET /dependencias/1
  # GET /dependencias/1.json
  def show
	add_breadcrumb "Datos de la dependencia", :dependencia_path
    @dependencia = Dependencia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @dependencia }
    end
  end

  # GET /dependencias/new
  # GET /dependencias/new.json
  def new
	add_breadcrumb "Nueva dependencia", :new_dependencia_path
    @dependencia = Dependencia.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @dependencia }
    end
  end

  # GET /dependencias/1/edit
  def edit
	add_breadcrumb "Editar dependencia", :edit_dependencia_path
    @dependencia = Dependencia.find(params[:id])
  end

  # POST /dependencias
  # POST /dependencias.json
  def create
    @dependencia = Dependencia.new(params[:dependencia])

    respond_to do |format|
      if @dependencia.save
		guardar_log(session[:usuario_id], self.class.name,__method__.to_s, @dependencia,nil )
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
	@temp = @dependencia.dup 	
    respond_to do |format|
      if @dependencia.update_attributes(params[:dependencia])
		guardar_log(session[:usuario_id], self.class.name,__method__.to_s, @temp,@dependencia )
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
	@temp = @dependencia.dup 	
    @dependencia.destroy
	guardar_log(session[:usuario_id], self.class.name,__method__.to_s, @temp,nil )

    respond_to do |format|
      format.html { redirect_to dependencias_url }
      format.json { head :ok }
    end
  end
end
