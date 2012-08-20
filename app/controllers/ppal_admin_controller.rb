require 'gchart'

class PpalAdminController < ApplicationController
  before_filter :es_adminitrador 

  layout "administrador"
  add_breadcrumb "Inicio", :ppal_admin_index_path
  
  def index
  @line_chart = Gchart.line(:data => [0, 40, 10, 70, 20])
  

  #Libros alquilados por escuela

  @ejemplares_area = Ejemplar.find_by_sql("select count(e.id) as cantidad, b.area_conocimiento_id, c.nombre
											from alquileres a join lines_items l on (a.id = l.alquiler_id)
											join devoluciones d on (l.id = d.line_item_id)
											join ejemplares e on (l.ejemplar_id = e.id)
											join libros b on (e.libro_id = b.id) 
											join areas_conocimientos c on (b.area_conocimiento_id = c.id)
											where a.estatus = 'Alquilado'
											and d.estatus = 'Sin devolver'
											group by b.area_conocimiento_id")	

   
	 @datos = Array.new
	 @label = Array.new
	 @legend = Array.new
 	 @ejemplares_area.each do |area|
		@datos << area.cantidad	
		@label << area.nombre + " #{area.cantidad}" 
		@legend << area.nombre
	 end	
	 
      @pie_chart1 = Gchart.pie_3d(:data => @datos, :title => "Libros alquilados por area de conocimiento", :labels => @label, :legend => @legend, :theme => :thirty7signals,:size => '500x150')	


	 @ejemplares_escuela = Ejemplar.find_by_sql("select count(e.id) as cantidad, u.dependencia_id, c.nombre
													from alquileres a join lines_items l on (a.id = l.alquiler_id)
													join devoluciones d on (l.id = d.line_item_id)
													join ejemplares e on (l.ejemplar_id = e.id)
													join usuarios u on (a.usuario_id = u.id)
													join dependencias c on (u.dependencia_id = c.id )
													where a.estatus = 'Alquilado'
													and d.estatus = 'Sin devolver'
													group by c.id") 
	
	 @datos = Array.new
	 @label = Array.new
	 @legend = Array.new
 	 @ejemplares_escuela.each do |escuela|
		@datos << escuela.cantidad	
		@label << escuela.nombre + " #{escuela.cantidad}" 
		@legend << escuela.nombre
	 end	

	
	 @pie_chart2 = Gchart.pie_3d(:data => @datos, :title => "Ejemplares entregados a cada escuela", :labels => @label, :legend => @legend, :theme => :thirty7signals,:size => '500x150')	
  end




  

end
