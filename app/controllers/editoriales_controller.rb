class EditorialesController < ApplicationController
  
  before_filter :es_adminitrador

  layout "administrador"

  # GET /editoriales
  # GET /editoriales.json
  def index
	@search = Editorial.search(params[:search])
    @editoriales = @search.paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @editoriales }
    end
  end

  # GET /editoriales/1
  # GET /editoriales/1.json
  def show
    @editorial = Editorial.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @editorial }
    end
  end

  # GET /editoriales/new
  # GET /editoriales/new.json
  def new
    @editorial = Editorial.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @editorial }
    end
  end

  # GET /editoriales/1/edit
  def edit
    @editorial = Editorial.find(params[:id])
  end

  # POST /editoriales
  # POST /editoriales.json
  def create
    @editorial = Editorial.new(params[:editorial])

    respond_to do |format|
      if @editorial.save
        format.html { redirect_to @editorial, :notice => 'Editorial creada exitosamente.' }
        format.json { render :json => @editorial, :status => :created, :location => @editorial }
      else
        format.html { render :action => "new" }
        format.json { render :json => @editorial.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /editoriales/1
  # PUT /editoriales/1.json
  def update
    @editorial = Editorial.find(params[:id])

    respond_to do |format|
      if @editorial.update_attributes(params[:editorial])
        format.html { redirect_to @editorial, :notice => 'Editorial actualizada exitosamente.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @editorial.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /editoriales/1
  # DELETE /editoriales/1.json
  def destroy
    @editorial = Editorial.find(params[:id])
    @editorial.destroy

    respond_to do |format|
      format.html { redirect_to editoriales_url }
      format.json { head :ok }
    end
  end
end
