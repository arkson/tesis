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

		xml = Builder::XmlMarkup.new 
		xml_data = @coleccion.to_xml (:include => {:usuario => {:include => :dependencia},:line_item => {:include => :ejemplar} } )     
		file = File.new("/home/arcadio/my_xml_data_file.xml", "w")
		file.write(xml_data)
		file.close  
    	send_doc( @coleccion.to_xml (:include => {:usuario => {:include => :dependencia}, :line_item => {:include => :ejemplar} } ), '/alquileres/alquiler/line-item/line-item/ejemplar', 'rptNumUsuariosEscuela.jasper', "Libros Adquiridos", params[:output_type])

	end

	def libros_sin_alquiler
		fecha = Time.now - 365*2   
		params[:output_type] = "pdf"
		@coleccion = Ejemplar.find_by_sql('select * from 
											((select e.*, d.nombre as dependencia
											from ejemplares e join lines_items l on (e.id = l.ejemplar_id)
											join libros b on (e.libro_id = b.id) 
											join dependecia d on (b.dependencia_id = d.id) 		
											where e.created_at <= :fecha1)  
											union
											(select e.*, d.nombre as dependencia
											from ejemplares e join lines_items l on (e.id = l.ejemplar_id)
											join libros b on (e.libro_id = b.id) 
											join dependecia d on (b.dependencia_id = d.id)
											where e.id in not (select ejemplar_id 
															   from lines_items )
											and e.created_at <= :fecha2	)) t order by dependecia, t.nombre asc ',{:fecha1 => fecha, :fecha2 =fecha } )

			
		

	end

end
