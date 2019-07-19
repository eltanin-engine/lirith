module Lirith
  abstract class Application
    def initialize
      setup

      Managers::System.trigger_event(Events::Application::Initialized)
    end

    abstract def setup
  end
end
