module Lirith
  module Renderers
    module OpenGL
      class Core
        def initialize(@scene : Scene, @camera : Camera)
        end

        def render
          LibGL.clear LibGL::E_COLOR_BUFFER_BIT | LibGL::E_DEPTH_BUFFER_BIT

          LibGL.enable LibGL::E_DEPTH_TEST
          LibGL.depth_func LibGL::E_LESS

          set_background

          @scene.children.each do |object|
            case object
            when Objects::Mesh; render(object)
              # update buffers
              # Use program
              # set uniforms
              # bind buffers
              # render triangles
            end
          end
        end

        def set_background
          LibGL.clear_color(
            @scene.background_color.red,
            @scene.background_color.green,
            @scene.background_color.blue,
            @scene.background_color.alpha
          )
        end

        def bind_program(material : Materials::Base)
          program = ShaderLib.find(:basic)
          program.use

          Elements::Material.update(material) if material.needs_update?
          program.uniform("color", material.color)

          program.uniform("view", @camera.view.inverse)
          program.uniform("projection", @camera.projection)

          program.uniform("use_texture", 0_u8)
          if texture = material.texture
            texture.render_attributes.try(&.use)
            Elements::Texture.use(texture)
            program.uniform("use_texture", 1_u8)
          end

          program
        end

        def render(object : Objects::Mesh)
          program = bind_program(object.material)

          Elements::Object.update(object) if object.needs_update?

          program.uniform("world", object.view)

          object.render_attributes.try(&.use) # try or not_nil! ?

          LibGL.draw_arrays LibGL::E_TRIANGLES, 0, object.vertices.size

          object.render_attributes.try(&.close)

          if texture = object.material.texture
            texture.render_attributes.try(&.close)
          end
        end
      end
    end
  end
end
