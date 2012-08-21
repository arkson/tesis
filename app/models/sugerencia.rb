class Sugerencia < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :libro
end
