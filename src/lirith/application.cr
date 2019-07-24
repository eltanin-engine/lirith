module Lirith
  abstract class Application
    def initialize
      Lirith::Managers::System.instance.register(Systems::Core.new)

      setup

      Managers::System.trigger_direct_event(Events::Application::Initialized)
      Managers::System.instance.run
    end

    abstract def setup
  end
end
