class InformacionController < ApplicationController
	
  skip_before_filter :authorize, :only => [:historia, :servicios, :normativas, :horarios]

  def historia
	@search = Noticia.where(:tipo_contenido => 'Historia')
	@historias =  @search.paginate(:page => params[:page], :per_page => 30)
	respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @historias }
    end

  end

  def servicios
	@search = Noticia.where(:tipo_contenido => 'Servicio')
	@servicios =  @search.paginate(:page => params[:page], :per_page => 30)
	respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @servicios }
    end


  end

  def normativas
	@search = Noticia.where(:tipo_contenido => 'Normativa')
	@normativas =  @search.paginate(:page => params[:page], :per_page => 30)
	respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @normativas }
    end
	
  end

  def horarios
	@search = Noticia.where(:tipo_contenido => 'Horario')
	@horarios =  @search.paginate(:page => params[:page], :per_page => 30)
	respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @horarios }
    end


  end



   



end
