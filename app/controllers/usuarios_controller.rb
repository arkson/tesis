class UsuariosController < ApplicationController
  before_filter :es_adminitrador
  layout "administrador"
  add_breadcrumb "Mantenimiento", :ppal_admin_index_path

  def index
	add_breadcrumb "Listado de Usuario", :usuarios_path
	@search = Usuario.search(params[:search])
    @usuario = @search.order(:nombre)
    @usuarios = @usuario.paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @usuarios }
    end
  end

  # GET /usuarios/1
  # GET /usuarios/1.json
  def show
	add_breadcrumb "Mostrar usuario", :usuario_path
    @usuario = Usuario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @usuario }
    end
  end

  # GET /usuarios/new
  # GET /usuarios/new.json
  def new
	add_breadcrumb "Nuevo usuario", :new_usuario_path
    @usuario = Usuario.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @usuario }
    end
  end

  # GET /usuarios/1/edit
  def edit
	add_breadcrumb "Editar usuario", :edit_usuario_path
    @usuario = Usuario.find(params[:id])
  end

  # POST /usuarios
  # POST /usuarios.json
  def create
    @usuario = Usuario.new(params[:usuario])

    respond_to do |format|
      if @usuario.save
		guardar_log(session[:usuario_id], self.class.name,__method__.to_s, @usuario,nil )
		format.html { redirect_to usuarios_url,:notice => "Usuario #{@usuario.nombre} fue creado exitosamente." }
        format.json { render :json => @usuario, :status => :created, :location => @usuario }
      else
        format.html { render :action => "new" }
        format.json { render :json => @usuario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /usuarios/1
  # PUT /usuarios/1.json
  def update
    @usuario = Usuario.find(params[:id])
	@temp = @usuario.dup
    respond_to do |format|
      if @usuario.update_attributes(params[:usuario])
		guardar_log(session[:usuario_id], self.class.name,__method__.to_s, @temp,@usuario)
		format.html { redirect_to usuarios_url,:notice => 'Usuario #{@usuario.nombre} fue actualizado correctamente.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @usuario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.json
  def destroy
    @usuario = Usuario.find(params[:id])
	@temp = @usuario.dup
    @usuario.destroy
	guardar_log(session[:usuario_id], self.class.name,__method__.to_s, @temp,nil )
    respond_to do |format|
      format.html { redirect_to usuarios_url }
      format.json { head :ok }
    end
  end
end
