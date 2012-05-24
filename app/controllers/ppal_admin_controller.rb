class PpalAdminController < ApplicationController
  before_filter :es_adminitrador 

  layout "administrador"
  add_breadcrumb "Inicio", :ppal_admin_index_path
  def index
  end




  

end
