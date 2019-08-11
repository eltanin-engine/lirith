module Lirith
  class Input
    enum Keys
      Key0           = LibGLFW::KEY_0
      Key1           = LibGLFW::KEY_1
      Key2           = LibGLFW::KEY_2
      Key3           = LibGLFW::KEY_3
      Key4           = LibGLFW::KEY_4
      Key5           = LibGLFW::KEY_5
      Key6           = LibGLFW::KEY_6
      Key7           = LibGLFW::KEY_7
      Key8           = LibGLFW::KEY_8
      Key9           = LibGLFW::KEY_9
      A              = LibGLFW::KEY_A
      B              = LibGLFW::KEY_B
      C              = LibGLFW::KEY_C
      D              = LibGLFW::KEY_D
      E              = LibGLFW::KEY_E
      F              = LibGLFW::KEY_F
      G              = LibGLFW::KEY_G
      H              = LibGLFW::KEY_H
      I              = LibGLFW::KEY_I
      J              = LibGLFW::KEY_J
      K              = LibGLFW::KEY_K
      L              = LibGLFW::KEY_L
      M              = LibGLFW::KEY_M
      N              = LibGLFW::KEY_N
      O              = LibGLFW::KEY_O
      P              = LibGLFW::KEY_P
      Q              = LibGLFW::KEY_Q
      R              = LibGLFW::KEY_R
      S              = LibGLFW::KEY_S
      T              = LibGLFW::KEY_T
      U              = LibGLFW::KEY_U
      V              = LibGLFW::KEY_V
      W              = LibGLFW::KEY_W
      X              = LibGLFW::KEY_X
      Y              = LibGLFW::KEY_Y
      Z              = LibGLFW::KEY_Z
      KeyGraveAccent = LibGLFW::KEY_GRAVE_ACCENT
      KeyEscape      = LibGLFW::KEY_ESCAPE
    end

    def self.handle_key(window : LibGLFW::Window*, key : Int32, scancode : Int32, action : Int32, mods : Int32) : Void
      case action
      when LibGLFW::PRESS  ; Managers::System.trigger_event(Events::Input::KeyPressed.new(Keys.new(key)))
      when LibGLFW::RELEASE; Managers::System.trigger_event(Events::Input::KeyReleased.new(Keys.new(key)))
      when LibGLFW::REPEAT ; Managers::System.trigger_event(Events::Input::KeyPressed.new(Keys.new(key)))
      end
    end
  end
end
