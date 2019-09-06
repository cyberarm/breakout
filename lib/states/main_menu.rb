module Breakout
  class MainMenu < CyberarmEngine::GuiState
    def setup
      window.show_cursor = true

      label "BREAKOUT", text_size: 32
      button "Play" do
        push_state(Game)
      end

      button "Exit" do
        window.close
      end
    end
  end
end