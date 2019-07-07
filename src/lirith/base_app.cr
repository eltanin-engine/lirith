module Lirith
  abstract class BaseApp
    def initialize
      Managers::System.instance.register(Application::Systems::Console.new)
      Managers::System.instance.register(Application::Systems::Window.new)
      Managers::System.instance.register(Application::Systems::Input.new)
      Managers::System.instance.register(Application::Systems::Render.new)
      Managers::System.instance.register(Application::Systems::Clock.new)
      Managers::System.instance.register(Application::Systems::Scene.new)

      Managers::System.trigger_event(Event::InitializationCompleted)
    end

    def run
      # while true
      #  Managers::System.trigger_event(Event::RenderStart)

      #  break if LibGLFW.get_key(Managers::System.instance.get(Application::Systems::Window).handle, LibGLFW::KEY_ESCAPE) == LibGLFW::PRESS

      #  renderer.render(Managers::System.instance.get(Application::Systems::Scene))
      #  Managers::System.trigger_event(Event::RenderEnd)

      #  Managers::System.trigger_event(Event::RenderFinalize)
      # end

      # shut_down
    end

    def shut_down
      Managers::System.instance.get(Core::Systems::Window).shut_down
    end
  end
end
