class Dependencia < ActiveRecord::Base
   has_many :libro
   has_many :usuario	
end
