class Noticia < ActiveRecord::Base

	has_attached_file :imagen, :styles => { :medium => "300x300>", :thumb => "60x60>" }

end
