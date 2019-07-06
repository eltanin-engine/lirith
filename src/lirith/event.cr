module Lirith
  enum Event
    # Application
    InitializationCompleted

    # Systems

    # # Render
    RenderStart
    RenderEnd
    RenderFinalize

    # Window
    WindowOpen
    WindowsClose
  end
end
