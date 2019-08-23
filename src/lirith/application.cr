module Lirith
  abstract class Application
    getter window = Window.new
    getter game_clock = Clocks::Game.new
    getter scene = Scene.new
    getter renderer = Renderers::OpenGL
    getter camera = Camera.new

    def initialize
      Lirith.application = self

      Lirith::Managers::System.instance.register(Systems::Application.new)

      setup

      Managers::System.trigger_direct_event(Events::Application::Initialized)

      Managers::System.instance.run
    end

    abstract def setup
  end
end
