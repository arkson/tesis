require 'pdf/writer'


class ReportesController < ApplicationController


 


	def example
		@solvencia = Usuario.all
		nombre_completo_archivo_pdf = "SOLVENCIA_PDF_GRADO"
		pdf = PDF::Writer.new

		# CODIGO PARA GENEREAR EL PDF

		pdf.margins_pt(40,20,20,20)
		pdf.select_font('Times-Roman')

		pdf.start_page_numbering(500, 760, size=9, pos = nil, pattern = "PAG. <PAGENUM> DE <TOTALPAGENUM>", starting = nil)

		pdf.text "", :font_size => 10, :justification => :center
		pdf.text "UNIVERSIDAD CENTRAL DE VENEZUELA", :justification => :center
		pdf.text "FACULTAD DE CIENCIAS", :justification => :center
		pdf.text "BIBLIOTECA ALONSO GAMERO", :justification => :center
		pdf.text "BOLSA DEL LIBRO", :justification => :center
		pdf.save_as(nombre_completo_archivo_pdf)
		f = File.open(nombre_completo_archivo_pdf, 'rb')
		contenido = f.read
		f.close
		send_data(contenido, { :type => "application/pdf", :filename => "solvencia_#{session[:cedula]}_#{@solvencia[0].cedula}-#{@solvencia[0].nombre}.pdf"})

	end



end
