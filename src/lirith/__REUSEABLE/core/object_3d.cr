module Lirith
  class Object3D
    property name = ""

    property position
    property quaternion # 3d rotation
    property scale

    property? visible = true

    property children : Array(Object3D) = [] of Object3D

    def initialize
      @position = Math::Vector3.zero
      @quaternion = Math::Quaternion.zero
      @scale = Math::Vector3.new(1, 1, 1)
    end

    def <<(object : Object3D)
      add(object)
    end

    def push(object : Object3D)
      children.push(object)
    end
  end
end