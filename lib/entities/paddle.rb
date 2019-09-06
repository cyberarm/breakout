module Breakout
  class Paddle < CyberarmEngine::GameObject
    attr_reader :box
    WIDTH = 128
    HEIGHT = 16

    def setup
      @drag = 0.89
      @speed = 1.0

      @box = CyberarmEngine::BoundingBox.new
    end

    def draw
      draw_rect(@position.x, @position.y, WIDTH, HEIGHT, @color)
    end

    def update
      @position += @velocity
      @velocity *= @drag

      @velocity.x -= @speed if window.button_down?(Gosu::KbLeft) || window.button_down?(Gosu::KbA)
      @velocity.x += @speed if window.button_down?(Gosu::KbRight) || window.button_down?(Gosu::KbD)

      if @position.x <= 0
        @position.x, @velocity.x = 1, 0
      end
      if @position.x >= window.width - WIDTH
        @position.x, @velocity.x = window.width - (WIDTH + 1), 0
      end

      update_box
    end

    def update_box
      @box.min = @position
      @box.max = CyberarmEngine::Vector.new(@position.x + WIDTH, @position.y + HEIGHT)
    end
  end
end