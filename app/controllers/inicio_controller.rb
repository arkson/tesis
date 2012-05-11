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

end
