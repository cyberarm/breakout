module Breakout
  class Window < CyberarmEngine::Engine
    def initialize(*args)
      super(*args)

      self.caption = "BREAKOUT"

      push_state(MainMenu)
    end
  end
end