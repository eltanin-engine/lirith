require "./base"
require "./opengl/*"

module Lirith
  module Renderers
    module OpenGL
      extend self

      def render(scene : Scene, camera : Camera)
        # Check if it's the correct order.
        # It used to be;
        # Set scene color
        # Clear LibGL bits
        # Use program
        # Set uniform
        LibGL.clear LibGL::E_COLOR_BUFFER_BIT | LibGL::E_DEPTH_BUFFER_BIT

        LibGL.enable LibGL::E_DEPTH_TEST
        LibGL.depth_func LibGL::E_LESS

        draw_call = DrawCall.new
        draw_call.uniforms["view"] = camera.view.inverse
        draw_call.uniforms["projection"] = camera.projection

        render(scene, draw_call)
      end

      def render(object : Object, draw_call : DrawCall)
        case object
        when Scene        ; Elements::Scene.render(object, draw_call)
        when Objects::Mesh; Elements::Mesh.render(object, draw_call)
        end

        object.children.each { |child| render(child, draw_call) } if object.responds_to?(:children)

        if error = LibGL.get_error
          return nil if error == LibGL::E_NO_ERROR
          puts "GL error at: 0x#{error.to_s(16)}"
        end
      end
    end
  end
end
