class InicioController < ApplicationController
  skip_before_filter :authorize



  def index
	
	@search = Noticia.where(:tipo_contenido => 'Noticia')
	@noticias =  @search.paginate(:page => params[:page], :per_page => 30)
	respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @noticias }
    end
  end
  
  def catalogo
	@search = Libro.search(params[:search])
    @libros = @search.paginate(:page => params[:page], :per_page => 5)
	@areas = AreaConocimiento.all
	respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @libros }
    end
  end

  def catalogo_categorias
	@result = Libro.where('area_conocimiento_id = :param',{:param => params[:param]})
	@areas = AreaConocimiento.all
	@search = @result.search(params[:search])
    @libros = @search.paginate(:page => params[:page], :per_page => 5)

	respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @libros }
    end
  end

 def olvido_clave
	@clave_plana_aleatoria = (rand * 9999999).ceil # genera la clave aleatoria
	@usuario_encontrado = Usuario.find_by_cedula(params[:cedula])
	@temp = @usuario_encontrado.dup
	@usuario_encontrado.password_digest = @usuario_encontrado.encriptar(@clave_plana_aleatoria)
    @usuario_encontrado.save
	guardar_log(@usuario_encontrado.id, self.class.name,__method__.to_s, @temp,@usuario_encontrado )
	ClaveMailer.olvido_clave(@usuario_encontrado,@clave_plana_aleatoria).deliver
	redirect_to inicio_index_url, :alert => "Su nueva clave de acceso al Sistema ha sido enviada a su correo"
 end



end
