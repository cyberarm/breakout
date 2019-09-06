begin
  require_relative "../cyberarm_engine/lib/cyberarm_engine"
rescue LoadError
  require "cyberarm_engine"
end

require_relative "lib/window"
require_relative "lib/states/main_menu"
require_relative "lib/states/game"
require_relative "lib/states/game_over"
require_relative "lib/states/game_won"

require_relative "lib/entities/paddle"
require_relative "lib/entities/puck"
require_relative "lib/entities/brick"
require_relative "lib/entities/wall"

Breakout::Window.new.show