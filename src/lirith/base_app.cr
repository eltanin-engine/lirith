module Lirith
  abstract class BaseApp
    def initialize
      Managers::System.instance.register(Application::Systems::Console.new)
      Managers::System.instance.register(Application::Systems::Window.new)
      Managers::System.instance.register(Application::Systems::Input.new)
      Managers::System.instance.register(Application::Systems::Render.new)
      Managers::System.instance.register(Application::Systems::Clock.new)
      Managers::System.instance.register(Application::Systems::Scene.new)

      Managers::System.trigger_event(Core::Events::Application::Initialized)
    end

    def shut_down
      Managers::System.instance.get(Systems::Window).shut_down
    end
  end
end
