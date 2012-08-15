class Usuario < ActiveRecord::Base
  has_many :alquiler
  belongs_to :dependencia
  validates :cedula,:nombre,:correo, :presence => true, :uniqueness => true
  validates :unid_creditos, :numericality => {:greater_than => -1}

  has_secure_password

  def encriptar(password_digest)
	BCrypt::Password.create(password_digest)
  end

end
