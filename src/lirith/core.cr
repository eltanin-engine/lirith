module Lirith
  class Core
    getter window
    getter game_clock
    getter scene
    getter renderer
    getter camera

    def initialize
      @window = Window.new
      @game_clock = Clocks::Game.new
      @scene = Scene.new
      @renderer = Renderers::OpenGL.new
      @camera = Camera.new

      # Managers::System.register(self)
    end
  end
end
