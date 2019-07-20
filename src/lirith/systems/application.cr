require "./base"

module Lirith
  module Systems
    class Application < Base
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

        Managers::System.register(self)
      end

      def handle_event(event)
        # case event
        # when Events::Clock::Start; game_clock.start && clock = game
        # when Events::Clock::Stop ; game_clock.stop && clock = game
        # end
      end
    end
  end
end
