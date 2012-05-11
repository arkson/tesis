class Usuario < ActiveRecord::Base

  belongs_to :dependencia
  validates :cedula, :presence => true, :uniqueness => true
  has_secure_password

end
