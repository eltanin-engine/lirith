module Lirith
  abstract class Application
    def initialize
      Managers::System.instance.register(Systems::Console.new)

      setup

      Managers::System.trigger_event(Events::Application::Initialized)
    end

    abstract def setup
  end
end
