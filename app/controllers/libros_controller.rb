require 'googlebooks'

class LibrosController < ApplicationController
	before_filter :es_adminitrador
  	skip_before_filter :es_adminitrador, :only => :autocomplete_libro_titulo

	layout "administrador"
    add_breadcrumb "Mantenimiento", :ppal_admin_index_path

	autocomplete :libro, :titulo
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

  def busqueda

    @isbn = params[:isbn]
	@books = GoogleBooks.search('isbn:'+@isbn)
	if !@books.first.nil?	
		first_book = @books.first
		@imagen = first_book.image_link
		@autor = first_book.authors 
		@titulo = first_book.title
		@editorial = first_book.publisher 
		@isbn = first_book.isbn 	
		@ano = first_book.published_date 
	end
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

  # POST /libros
  # POST /libros.json
  def create
    @libro = Libro.new(params[:libro])

    respond_to do |format|
      if @libro.save
		guardar_log(session[:usuario_id], self.class.name,__method__.to_s, @libro,nil )
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
	@temp = @libro.dup
    respond_to do |format|
      if @libro.update_attributes(params[:libro])
		guardar_log(session[:usuario_id], self.class.name,__method__.to_s, @temp,@libro  )

        format.html { redirect_to @libro, :notice => 'Libro actualizado exitosamente.' }
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
	@temp = @libro.dup
    @libro.destroy
	guardar_log(session[:usuario_id], self.class.name,__method__.to_s, @temp,nil )
    respond_to do |format|
      format.html { redirect_to libros_url, :notice => 'Libro eliminado exitosamente.'  }
      format.json { head :ok }
    end
  end


end
