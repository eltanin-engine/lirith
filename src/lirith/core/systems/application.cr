module Lirith
  module Core
    module Systems
      class Application < Base
        getter window
        getter game_clock

        def initialize
          @window = Window.new
          @game_clock = Clocks::Game.new

          Managers::System.register(self)
        end

        def handle_event(event, payload)
          case event
          when Core::Clocks::Event::Start; game_clock.start
          when Core::Clocks::Event::Stop ; game_clock.stop
          end
        end
      end
    end
  end
end
