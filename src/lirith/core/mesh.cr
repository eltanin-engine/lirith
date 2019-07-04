require "./object_3d"
module Lirith
  class Mesh < Object3D
    def initialize(@geometry, @material)
      super()
      
    end
  end
end
