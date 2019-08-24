require "./program"
module Lirith
  module Renderers
    module OpenGL
      class ShaderLib
        include Singleton

        getter programs = {} of Symbol => Program

        def build_program(name : Symbol)
          program = Program.new
          program.attach Shader.from_file(LibGL::E_VERTEX_SHADER, "#{name}.vs.glsl")
          program.attach Shader.from_file(LibGL::E_FRAGMENT_SHADER, "#{name}.fs.glsl")
          program.link
          # Call shader delete after linking

          program
        end

        def find(name : Symbol)
          return @programs[name] if @programs.has_key?(name)

          @programs[name] = build_program(name)
        end

        def self.find(name : Symbol)
          instance.find(name)
        end
      end
    end
  end
end
