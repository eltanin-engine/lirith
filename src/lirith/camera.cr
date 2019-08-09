require "./renderer"

module Lirith
  class Camera
    include Renderer::Drawable

    property projection

    property fov = 45_f32

    property width = 1024_f32 # Theise are the same as in the window, might want to leave it there
    property height = 768_f32

    property near = 1_f32
    property far = 2000_f32

    def initialize
      @position.z = Float32.new(10)

      @projection = Math::Matrix4.perspectiveFov(@fov, @width / @height, @near, @far)
      update_view
    end

    def update_projection
      Math::Matrix4.perspectiveFov(@fov, @width / @height, @near, @far)
    end

    def look_at(vector : Vector3)
      matrix = Math::Matrix4.look_at(@position, vector, Math::Vector3.up)
      quaternion.setFromRotation(matrix)
    end
  end
end
