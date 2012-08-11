class Donacion < ActiveRecord::Base
  belongs_to :ejemplar
  belongs_to :usuario
end
