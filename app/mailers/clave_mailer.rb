class ClaveMailer < ActionMailer::Base
  #default :from => "from@example.com"

  def olvido_clave(usuario)  
	mail(:to => usuario.correo, :subject => "Envio de clave", :from => "kennysoytupadre@gmail.com")  
  end   

end
