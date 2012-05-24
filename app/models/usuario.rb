class Usuario < ActiveRecord::Base
  has_many :alquiler
  belongs_to :dependencia
  validates :cedula, :presence => true, :uniqueness => true
  has_secure_password

  def encriptar(password_digest)
	BCrypt::Password.create(password_digest)
  end

end
