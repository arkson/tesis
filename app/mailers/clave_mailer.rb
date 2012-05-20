class ClaveMailer < ActionMailer::Base
  #default :from => "from@example.com"

  def olvido_clave(usuario)  
	mail(:to => usuario.correo, :subject => "Nueva Clave de Inicio de Sesión", :from => "bolsadelibro")  
  end   

end
