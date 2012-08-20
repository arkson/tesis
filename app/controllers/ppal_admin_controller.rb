require 'gchart'

class PpalAdminController < ApplicationController
  before_filter :es_adminitrador 

  layout "administrador"
  add_breadcrumb "Inicio", :ppal_admin_index_path
  
  def index
#theme => keynote, thirty7signals, pastel, greyscale   

###Libros alquilados agrupados por area de conocimiento

	
  @ejemplares_area = Ejemplar.find_by_sql("select count(e.id) as cantidad, b.area_conocimiento_id, c.nombre
											from alquileres a join lines_items l on (a.id = l.alquiler_id)
											join devoluciones d on (l.id = d.line_item_id)
											join ejemplares e on (l.ejemplar_id = e.id)
											join libros b on (e.libro_id = b.id) 
											join areas_conocimientos c on (b.area_conocimiento_id = c.id)
											where a.estatus = 'Alquilado'
											and d.estatus = 'Sin devolver'
											group by b.area_conocimiento_id")	
# #{user.name} (#{total == 0 ? 0 : (100.0 * number / total).round}%)"

  	 total = @ejemplares_area.to_a.sum{|ejem| ejem.cantidad}   
	 @datos = Array.new
	 @label = Array.new
	 @legend = Array.new
 	 @ejemplares_area.each do |area|
		@datos << area.cantidad
		porc = area.cantidad * 100 / total	
		@label << area.nombre + " %#{porc} " 
		@legend << area.nombre + " (#{area.cantidad})"
	 end	
	 
      @pie_chart1 = Gchart.pie_3d(:data => @datos, :title => "Libros alquilados por area de conocimiento", :labels => @label, :legend => @legend, :theme => :thirty7signals,:size => '550x150')	


##################################################################################################################
#Libros alquilados agrupados por escuela de alumno solicitante



	 @ejemplares_escuela = Ejemplar.find_by_sql("select count(e.id) as cantidad, u.dependencia_id, c.nombre
													from alquileres a join lines_items l on (a.id = l.alquiler_id)
													join devoluciones d on (l.id = d.line_item_id)
													join ejemplares e on (l.ejemplar_id = e.id)
													join usuarios u on (a.usuario_id = u.id)
													join dependencias c on (u.dependencia_id = c.id )
													where a.estatus = 'Alquilado'
													and d.estatus = 'Sin devolver'
													group by c.id") 
	 total = @ejemplares_escuela.to_a.sum{|ejem| ejem.cantidad} 
	 @datos = Array.new
	 @label = Array.new
	 @legend = Array.new
 	 @ejemplares_escuela.each do |escuela|
		@datos << escuela.cantidad	
		porc = escuela.cantidad * 100 / total	
		@label << escuela.nombre + " %#{porc} " 
		@legend << escuela.nombre + " (#{escuela.cantidad})"
	 end	

	
	 @pie_chart2 = Gchart.pie_3d(:data => @datos, :title => "Ejemplares entregados a cada escuela", :labels => @label, :legend => @legend, :theme=>:pastel, :size => '550x150')	


##################################################################################################################
#Libros alquilados agrupados por usuarios de las escuelas


     @usuarios_escuela = Ejemplar.find_by_sql("select count(distinct(u.id)) as cantidad, u.dependencia_id, c.nombre
												from alquileres a join lines_items l on (a.id = l.alquiler_id)
												join devoluciones d on (l.id = d.line_item_id)
												join ejemplares e on (l.ejemplar_id = e.id)
												join usuarios u on (a.usuario_id = u.id)
												join dependencias c on (u.dependencia_id = c.id )
												where a.estatus = 'Alquilado'
												and d.estatus = 'Sin devolver'
												group by c.id")

	 total = @usuarios_escuela.to_a.sum{|usu| usu.cantidad} 
	 @datos = Array.new
	 @label = Array.new
	 @legend = Array.new
 	 @usuarios_escuela.each do |usuario|
		@datos << usuario.cantidad	
		porc = usuario.cantidad * 100 / total	
		@label << usuario.nombre  + " %#{porc} " 
		@legend << usuario.nombre + " (#{usuario.cantidad})"
	 end	

	
	 @pie_chart3 = Gchart.pie_3d(:data => @datos, :title => "Ejemplares entregados a cada escuela", :labels => @label, :legend => @legend, :theme => :greyscale,:size => '550x150')	



  end




  

end
