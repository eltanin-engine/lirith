module Lirith
  enum Event
    # Application
    InitializationCompleted
    ApplicationExit

    # Systems

    # # Render
    RenderStart
    RenderPaintStart
    RenderPaintEnd
    RenderPaintFinalize
    RenderStopped

    # Window
    WindowOpen
    WindowClose

    # Console
    ConsoleAskCommand
    ConsoleToggleLog
  end
end
