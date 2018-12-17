module Lirith
  class Object3D
    property position
    property quaternion #3d rotation
    property scale

    property? visible

    property children : Array(Object3D) = [] of Object3D

    def initialize
      @position = Math::Vector3.new(1.0.to_f32, 1.0.to_f32, 1.0.to_f32)
      @quaternion = Math::Quaternion.new(1.0.to_f32, 1.0.to_f32, 1.0.to_f32, 1.0.to_f32)
      @scale = Math::Vector3.new(1.0.to_f32, 1.0.to_f32, 1.0.to_f32)
    end

    def <<(object : Object3D)
      add(object)
    end

    def push(object : Object3D)
      children.push(object)
    end
  end
end
