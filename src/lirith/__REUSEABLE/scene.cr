module Lirith
  class Scene < Object3D
    property! background : Array(Float32)
    property! fov : Float32
    property! aspect : Float32

    # property! :horizontal_angle
    # property! :vertical_angle
    # property! :scene_ratio

    def initialize
      super

      @background = [0_f32, 0.2_f32, 0.1_f32, 1_f32]
      @fov = 45_f32
      @aspect = (4.0_f32/3.0_f32)
    end
  end
end
