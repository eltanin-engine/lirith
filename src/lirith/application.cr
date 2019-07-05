module Lirith
    abstract class Application
        def initialize
            Managers::System.instance.register(Core::Systems::Window.new)
            Managers::System.instance.register(Core::Systems::Clock.new)
        end

        def run
            scene = Scene.new
            renderer = Renderers::OpenGL.new

            while true
                Managers::Event.trigger("before_render")
                
                break if LibGLFW.get_key(Managers::System.instance.get(Core::Systems::Window).handle, LibGLFW::KEY_ESCAPE) == LibGLFW::PRESS                
                
                renderer.render( scene )
                Managers::Event.trigger("after_render")

                Managers::Event.trigger("finalize_frame") 
            end

            shut_down
        end

        def shut_down
            Managers::System.instance.get(Core::Systems::Window).shut_down
        end
    end
end