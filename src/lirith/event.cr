module Lirith
  enum Event
    # Application
    InitializationCompleted
    ApplicationExit

    # Window
    WindowOpen
    WindowClose

    # Console
    ConsoleAskCommand
    ConsoleToggleLog

    # Clocks
    GameClockStart
    GameClockStop

    # Input
    InputKeyRelease
    InputKeyPress

    # Systems

    # # Render
    RenderStart
    RenderPaintStart
    RenderPaintEnd
    RenderPaintFinalize
    RenderStopped
  end
end
