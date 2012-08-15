class Dependencia < ActiveRecord::Base
   has_many :libro
   has_many :usuario	
   validates :nombre, :presence => true  

end
