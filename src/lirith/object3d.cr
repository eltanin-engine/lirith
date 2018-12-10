module Lirith
  class Object3D
    property! :position
    property! :quaternion #3d rotation
    property! :scale

    property children : Array(Object3D) = [] of Object3D

    def initialize
      @position = Math::Vector3.new(1.0, 1.0, 1.0)
      @quaternion = Math::Quaternion.new(1.0, 1.0, 1.0, 1.0)
      @scale = Math::Vector3.new(1.0, 1.0, 1.0)
    end

    def <<(object : Object3D)
      add(object)
    end

    def push(object : Object3D)
      children.push(object)
    end
  end
end
