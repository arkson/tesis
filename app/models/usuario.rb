class Usuario < ActiveRecord::Base

  belongs_to :dependencia
  validates :cedula, :presence => true, :uniqueness => true
  has_secure_password

  def encriptar(password_digest,generador=cedula)
    self.class.encriptar(password_digest,generador)
  end

  def self.encriptar(password_digest,generador)
   Digest::SHA2.hexdigest("--1--#{password_digest}--#{generador}--0--")
  end

end
