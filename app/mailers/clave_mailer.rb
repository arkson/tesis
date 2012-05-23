class ClaveMailer < ActionMailer::Base
  #default :from => "from@example.com"

  def olvido_clave(usuario,clave_nueva)  
	@clave = clave_nueva
	mail(:to => usuario.correo, :subject => "Nueva Clave de Inicio de Sesión", :from => "bolsadelibro")  

  end   

end
