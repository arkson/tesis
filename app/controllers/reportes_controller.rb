require 'jasper-bridge'





class ReportesController < ApplicationController
	

   include Jasper::Bridge

   		#xml = Builder::XmlMarkup.new 
		#xml_data = @coleccion.to_xml (:include => {:libro => {:include => :dependencia} } )     
		#file = File.new("/home/arcadio/my_xml_data_file.xml", "w")
		#file.write(xml_data)
		#file.close
 
	

	def comprobante_alquiler

		params[:output_type] = "pdf"
		#@coleccion = Alquiler.joins( [{:line_item => :ejemplar}], :usuario )
        @coleccion = Alquiler.where(:id => params[:id])
		send_doc( @coleccion.to_xml ({:include => {:usuario => {}, :configuracion => {}, :line_item => {:include => {:ejemplar => {:include=>:libro}} }	 }}), '/alquileres/alquiler/line-item/line-item/ejemplar/libro', 'rptComprobanteAlquiler.jasper', "Recibo de Alquiler", params[:output_type])
       
			
	end


	def libros_alquilados

		params[:output_type] = "pdf"
		@coleccion = Ejemplar.joins(:libro).where(:estatus_ejemplar => "Alquilado").order('libros.dependencia_id asc')
		send_doc( @coleccion.to_xml (:include => {:libro => {:include => :dependencia} } ), '/ejemplares/ejemplar/libro/dependencia', 'rptLibrosAlquilados.jasper', "Libros Alquilados", params[:output_type])
	
	end


	def total_libros_alquilados
		params[:output_type] = "pdf"
		#@coleccion = Ejemplar.joins(:libro).where(:estatus_ejemplar => "Alquilado").order('libros.dependencia_id asc')

        @coleccion = Ejemplar.find_by_sql(" select * from ((select e.*, l.dependencia_id 
									      from ejemplares e join libros l on (e.libro_id = l.id )
										  where e.estatus_ejemplar = 'Alquilado' 
										  )										  
										  Union	
										  (select e.*, l.dependencia_id 
										  from ejemplares e  join libros l on (e.libro_id = l.id ) 
										  where e.libro_id in (select libro_id
															   from ejemplares 
															   where estatus_ejemplar = 'Alquilado')	
										   )) t order by t.dependencia_id asc, t.libro_id ")

   	
	

		send_doc( @coleccion.to_xml (:include => {:libro => {:include => :dependencia} } ), '/ejemplares/ejemplar/libro/dependencia', 'rptTotalLibrosAlquilados.jasper', "Total Libros Alquilados", params[:output_type])

	end 


	def libros_adquiridos

		params[:output_type] = "pdf"

		@coleccion = Ejemplar.joins(:libro).where('ejemplares.created_at  >= :tiempo1 and :tiempo2 <= ejemplares.created_at',{:tiempo1 => params[:finicio], :tiempo2 => params[:ffin] } ).order(' 	libros.dependencia_id asc ')
		send_doc( @coleccion.to_xml (:include => {:libro => {:include => :dependencia} } ), '/ejemplares/ejemplar/libro/dependencia', 'rptLibrosAdquiridos.jasper', "Libros Adquiridos", params[:output_type])
	

	end


	def num_alquiler_escuela 
		params[:output_type] = "pdf"
		@coleccion = Alquiler.joins(:usuario).where(:configuracion_id => '1').order('usuarios.dependencia_id, alquileres.usuario_id asc') 

		
    	send_doc( @coleccion.to_xml (:include => {:usuario => {:include => :dependencia}, :line_item => {:include => :ejemplar} } ), '/alquileres/alquiler/line-item/line-item/ejemplar', 'rptNumUsuariosEscuela.jasper', "Libros Adquiridos", params[:output_type])

	end

	def libros_sin_alquiler
		fecha = Time.now - 2.year   
		params[:output_type] = "pdf"
		@coleccion = Ejemplar.find_by_sql(['select * from ((select e.*, d.nombre as dependencia, b.titulo
															from ejemplares e join lines_items l on (e.id = l.ejemplar_id)
															join libros b on (e.libro_id = b.id) 
															join dependencias d on (b.dependencia_id = d.id) 		
															where e.fecha_ingreso <= ?
															and e.id in (select ejemplar_id 
																			   from lines_items 
																			   group by ejemplar_id
															   		     	   having max(created_at) <= ? ) )
															union
															(select e.*, d.nombre as dependencia, b.titulo
															from ejemplares e left join lines_items l on (e.id = l.ejemplar_id)
															join libros b on (e.libro_id = b.id) 
															join dependencias  d on (b.dependencia_id = d.id)
															where e.id not in (select ejemplar_id 
															from lines_items ) and e.fecha_ingreso <= ? )) t order by t.dependencia, titulo asc ',fecha, fecha, fecha] )

		xml = Builder::XmlMarkup.new 
		xml_data = @coleccion.to_xml (:include => {:libro => {:include => :dependencia} } )     
		file = File.new("/home/kenny/my_xml_data_file.xml", "w")
		file.write(xml_data)
		file.close	
					
		send_doc( @coleccion.to_xml (:include => {:libro => {:include => :dependencia} } ), '/ejemplares/ejemplar/libro/dependencia', 'rptLibrosSinAlquilar.jasper', "Libros Sin Alquilar", params[:output_type])

		
	end


	def solvencia
		params[:output_type] = "pdf"
		
		@coleccion = Usuario.where(:id => 1)#params[:usuario_d])
		
   
        xml = Builder::XmlMarkup.new 
		xml_data = @coleccion.to_xml (:include => { :dependencia => {} })     
		file = File.new("/home/kenny/my_xml_data_file.xml", "w")
		file.write(xml_data)
		file.close	
	  	
		send_doc( @coleccion.to_xml (:include => { :dependencia => {} }  ), '/usuarios/usuario/dependencia', 'rptSolvencia.jasper', "Solvencia", params[:output_type])		
				

	end 


	def deudores 
		params[:output_type] = "pdf"		
#		@coleccion = Usuario.find_by_sql(select * 
#from usuarios u join alquileres a on (u.id = a.usuario_id)
#join devoluciones d  on (a.id = d.alquiler_id) 
#join configuraciones c on (c.id = a.configuracion_id  )
#where d.estatus = "Sin entregar")

	end

end




#Calendar.getInstance().get(Calendar.MONTH) == new java.lang.Integer(1) ? "enero":
# (Calendar.getInstance().get(Calendar.MONTH) == new java.lang.Integer(2)?"febrero":
# (Calendar.getInstance().get(Calendar.MONTH) == new java.lang.Integer(3)?"marzo":
# (Calendar.getInstance().get(Calendar.MONTH) == new java.lang.Integer(4)?"Abril":
# (Calendar.getInstance().get(Calendar.MONTH) == new java.lang.Integer(5)?"mayo":
# (Calendar.getInstance().get(Calendar.MONTH) == new java.lang.Integer(6)?"junio":
# (Calendar.getInstance().get(Calendar.MONTH) == new java.lang.Integer(7)?"julio":
# (Calendar.getInstance().get(Calendar.MONTH) == new java.lang.Integer(8)?"agosto":
# (Calendar.getInstance().get(Calendar.MONTH) == new java.lang.Integer(9)?"septiembre":
# (Calendar.getInstance().get(Calendar.MONTH) == new java.lang.Integer(10)?"octubre":
# (Calendar.getInstance().get(Calendar.MONTH) == new java.lang.Integer(11)?"noviembre":
# (Calendar.getInstance().get(Calendar.MONTH) == new java.lang.Integer(12)?"diciembre")))))))))))

