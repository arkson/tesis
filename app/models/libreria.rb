class Libreria < ActiveRecord::Base
    has_many :ejemplar
    validates :nombre, :presence => true  
 
end
