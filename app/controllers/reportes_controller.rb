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

   	
		xml = Builder::XmlMarkup.new 
		xml_data = @coleccion.to_xml (:include => {:libro => {:include => :dependencia} } )     
		file = File.new("/home/kenny/my_xml_data_file.xml", "w")
		file.write(xml_data)
		file.close


		send_doc( @coleccion.to_xml (:include => {:libro => {:include => :dependencia} } ), '/ejemplares/ejemplar/libro/dependencia', 'rptTotalLibrosAlquilados.jasper', "Total Libros Alquilados", params[:output_type])

	end 


	def libros_adquiridos

		params[:output_type] = "pdf"

		@coleccion = Ejemplar.where('created_at  >= :tiempo1 and :tiempo2 <= created_at',{:tiempo1 => params[:finicio], :tiempo2 => params[:ffin] } )
		send_doc( @coleccion.to_xml (:include => {:libro => {:include => :dependencia} } ), '/ejemplares/ejemplar/libro/dependencia', 'rptLibrosAdquiridos.jasper', "Libros Adquiridos", params[:output_type])
	

	end

end
