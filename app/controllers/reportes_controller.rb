require 'jasper-bridge'





class ReportesController < ApplicationController
	

   include Jasper::Bridge

   
 
	

	def comprobante_alquiler

#Category.joins(:posts => [{:comments => :guest}, :tags])

		params[:output_type] = "pdf"
		#@coleccion = Alquiler.joins( [{:line_item => :ejemplar}], :usuario )
        @coleccion = Alquiler.where(:id => params[:id])

		xml = Builder::XmlMarkup.new 
		xml_data = @coleccion.to_xml ({:include => {:usuario => {}, :configuracion => {}, :line_item => {:include => {:ejemplar => {:include=>:libro}} }	 }}) 
		file = File.new("/home/kenny/my_xml_data_file.xml", "w")
		file.write(xml_data)
		file.close
		
 		send_doc( @coleccion.to_xml ({:include => {:usuario => {}, :configuracion => {}, :line_item => {:include => {:ejemplar => {:include=>:libro}} }	 }}), '/alquileres/alquiler/line-item/line-item/ejemplar/libro', 'rptComprobanteAlquiler.jasper', "Recibo de Alquiler", params[:output_type])
       
			
	end


	def libros_alquilados
		@coleccion = Ejemplar.joins()
 		
		xml = Builder::XmlMarkup.new 
		xml_data = @coleccion.to_xml (:include => {:libro => {:include => :dependecia  } } }  ) 
		file = File.new("/home/kenny/my_xml_data_file.xml", "w")
		file.write(xml_data)
		file.close

	
	end 


end
