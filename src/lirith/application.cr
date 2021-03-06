module Lirith
  abstract class Application
    getter window = Window.new(960,540, fullscreen: true)
    getter game_clock = Clocks::Game.new
    getter scene = Scene.new
    getter camera = Camera.new
    getter renderer = Renderers::OpenGL::Core.new(@scene, @camera)

    def initialize
      Lirith.application = self
      @camera.width = Float32.new(@window.width)
      @camera.height = Float32.new(@window.height)

      Lirith::Managers::System.instance.register(Systems::Application.new)

      setup

      Managers::System.trigger_direct_event(Events::Application::Initialized)

      Managers::System.instance.run
    end

    abstract def setup
  end
end
