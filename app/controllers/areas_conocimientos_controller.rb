class AreasConocimientosController < ApplicationController
  	  
  before_filter :es_adminitrador

  layout "administrador"

  # GET /areas_conocimientos
  # GET /areas_conocimientos.json
  def index
	@search = AreaConocimiento.search(params[:search])
    @areas_conocimientos = @search.paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @areas_conocimientos }
    end
  end

  # GET /areas_conocimientos/1
  # GET /areas_conocimientos/1.json
  def show
    @area_conocimiento = AreaConocimiento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @area_conocimiento }
    end
  end

  # GET /areas_conocimientos/new
  # GET /areas_conocimientos/new.json
  def new
    @area_conocimiento = AreaConocimiento.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @area_conocimiento }
    end
  end

  # GET /areas_conocimientos/1/edit
  def edit
    @area_conocimiento = AreaConocimiento.find(params[:id])
  end

  # POST /areas_conocimientos
  # POST /areas_conocimientos.json
  def create
    @area_conocimiento = AreaConocimiento.new(params[:area_conocimiento])

    respond_to do |format|
      if @area_conocimiento.save
		guardar_log(session[:usuario_id], self.class.name,__method__.to_s, @area_conocimiento,nil )	
        format.html { redirect_to @area_conocimiento, :notice => 'Area conocimiento was successfully created.' }
        format.json { render :json => @area_conocimiento, :status => :created, :location => @area_conocimiento }
      else
        format.html { render :action => "new" }
        format.json { render :json => @area_conocimiento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /areas_conocimientos/1
  # PUT /areas_conocimientos/1.json
  def update
    @area_conocimiento = AreaConocimiento.find(params[:id])
	@temp = @area_conocimiento.dup
    respond_to do |format|
      if @area_conocimiento.update_attributes(params[:area_conocimiento])
		guardar_log(session[:usuario_id], self.class.name,__method__.to_s, @temp,@area_conocimiento )	
        format.html { redirect_to @area_conocimiento, :notice => 'Area conocimiento was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @area_conocimiento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /areas_conocimientos/1
  # DELETE /areas_conocimientos/1.json
  def destroy
    @area_conocimiento = AreaConocimiento.find(params[:id])
	@temp = @area_conocimiento.dup
    @area_conocimiento.destroy
	guardar_log(session[:usuario_id], self.class.name,__method__.to_s, @temp,nil )	
    respond_to do |format|
      format.html { redirect_to areas_conocimientos_url }
      format.json { head :ok }
    end
  end
end
