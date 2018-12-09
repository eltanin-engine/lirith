module Lirith
  class Scene < Object3D
    property! :background
    property! :fov
    property! :aspect

    #property! :horizontal_angle
    #property! :vertical_angle
    #property! :scene_ratio

    def initialize
      super

      @background = [0, 0, 0.4, 1]
      @fov = 45.to_f32
      @aspect = (4.0/3.0).to_f32
    end

  end
end
