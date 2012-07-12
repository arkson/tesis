class LibrosController < ApplicationController
  	before_filter :es_adminitrador
	layout "administrador"
    add_breadcrumb "Mantenimiento", :ppal_admin_index_path
	
  # GET /libros
  # GET /libros.json
  def index
	add_breadcrumb "Listado de libros", :libros_index_path
	@search = Libro.search(params[:search])
    @libros = @search.paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @libros }
    end
  end

  # GET /libros/1
  # GET /libros/1.json
  def show
	add_breadcrumb "Datos del libro", :libro_path
    @libro = Libro.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @libro }
    end
  end

  # GET /libros/new
  # GET /libros/new.json
  def new
	add_breadcrumb "Nuevo libro", :new_libro_path
    @libro = Libro.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @libro }
    end
  end

  # GET /libros/1/edit
  def edit
	add_breadcrumb "Editar libro", :edit_libro_path
    @libro = Libro.find(params[:id])
  end

  def buscar_amazon
    @data = params[:isbn]

    begin
    Amazon::Ecs.configure do |options|
      options[:aWS_access_key_id] = 'AKIAIZ372MMDUEUTLORA'
      options[:aWS_secret_key] = '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'
    end

    res = Amazon::Ecs.item_search(@data, {:response_group => 'Medium', :sort => 'salesrank'})

    res.items.each do |item|
          @libro = Libro.new
          @libro.id_escuela = 1

      item.get('asin')
      item.get('itemattributes/title')
      atts = item.search_and_convert('itemattributes')

       @libro.imagen_url = "/images/libros/libro.jpg"

       begin
       @libro.imagen_url = item.get_hash("smallimage")[:url] || "Imagen No definida"
       rescue
       end

      @libro.titulo = atts.get('title') || "Titulo No definido"

      if  atts.get_array('author').empty?
        @libro.autor =  "Autor No definido"
      else
         @libro.autor =  atts.get_array('author')
      end

      @libro.isbn = atts.get('isbn')
      @libro.edicion = atts.get('edition') || "Edición No definida"
      @libro.editorial = atts.get('publisher') || "Editorial No definida"
    end

    rescue
      flash[:notice] = 'Hay un error de conexión'
    end
    #  dbh.disconnect
  end


  # POST /libros
  # POST /libros.json
  def create
    @libro = Libro.new(params[:libro])

    respond_to do |format|
      if @libro.save
        format.html { redirect_to @libro, :notice => 'Libro creado exitosamente.' }
        format.json { render :json => @libro, :status => :created, :location => @libro }
      else
        format.html { render :action => "new" }
        format.json { render :json => @libro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /libros/1
  # PUT /libros/1.json
  def update
    @libro = Libro.find(params[:id])

    respond_to do |format|
      if @libro.update_attributes(params[:libro])
        format.html { redirect_to @libro, :notice => 'Libro was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @libro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /libros/1
  # DELETE /libros/1.json
  def destroy
    @libro = Libro.find(params[:id])
    @libro.destroy

    respond_to do |format|
      format.html { redirect_to libros_url }
      format.json { head :ok }
    end
  end
end
