class Editorial < ActiveRecord::Base
   has_many :libro

	validates :nombre, :presence => true  

end
