module Breakout
  class GameOver < CyberarmEngine::GuiState
    def setup
      label "Game Over"
      button "Main Menu" do
        push_state(MainMenu)
      end
    end
  end
end