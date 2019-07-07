module Lirith
  enum Event
    # Application
    InitializationCompleted
    ApplicationExit

    # Systems

    # # Render
    RenderStart
    RenderEnd
    RenderFinalize
    RenderStopped

    # Window
    WindowOpen
    WindowClose
  end
end
