class Usuario < ActiveRecord::Base
  has_many :alquiler
  belongs_to :dependencia
  validates :cedula, :presence => true, :uniqueness => true
  has_secure_password

end
