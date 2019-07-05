require "lib_glfw"
module Lirith
  module Controls
    class Fly < BaseControls
      property speed = 3_f32
      property mouse_speed = 0.05_f32

      #def initialize
      #  @window = 1
      #  GLFW.get_cursor_pos @window, out @last_xpos, out @last_ypos
      #end

      def key_press(key)
        case key
        when KEY_W
          # Move forward
        when KEY_A
          # Move left
        when KEY_S
          # Move backward
        when KEY_D
          # Move right
        end
      end

      def update(delta, scene)
        # ??
      end
      #def update(delta, scene)
      #  scene.horizontal_angle += mouse_speed * delta * (@last_xpos - xpos)
      #  scene.vertical_angle += mouse_speed * delta * (@last_ypos - ypos)

      #  @last_xpos = xpos
      #  @last_ypos = ypos

        # process keys
      #  if GLFW.get_key(@window, GLFW::KEY_W) == GLFW::PRESS
      #    @scene.position += @scene.direction * delta_time * @speed
      #  end
      #  if GLFW.get_key(@window, GLFW::KEY_S) == GLFW::PRESS
      #    @scene.position -= @scene.direction * delta_time * @speed
      #  end
      #  if GLFW.get_key(@window, GLFW::KEY_A) == GLFW::PRESS
      #    @scene.position -= @scene.right * delta_time * @speed
      #  end
      #  if GLFW.get_key(@window, GLFW::KEY_D) == GLFW::PRESS
      #    @scene.position += @scene.right * delta_time * @speed
      #  end
      #end
    end
  end
end
