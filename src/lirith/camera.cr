module Lirith
  class Camera < BaseObject
    property projection = Math::Matrix4.perspectiveFov(
      Float32.new(45),
      Float32.new(1.33333),
      Float32.new(0.1),
      Float32.new(100))

    # property model =

    def initialize
      # @position.x = Float32.new(5)
      # @position.y = Float32.new(5)
      @position.z = Float32.new(5)
    end

    def mvp
      dir = Math::Vector3.new(0.001592548, 0.0, -0.99999875)
      up = Math::Vector3.new(-0.0, 1.0, 0.0)
      view = Math::Matrix4.look_at(@position, @position + dir, up)
      model = Math::Matrix4.identity
      projection * view * model
    end
  end
end
