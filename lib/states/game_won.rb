module Breakout
  class GameWon < CyberarmEngine::GuiState
    def setup
      label "Game Won"
      button "Main Menu" do
        push_state(MainMenu)
      end
    end
  end
end