class Devolucion < ActiveRecord::Base
  belongs_to :alquiler
  belongs_to :line_item
end
