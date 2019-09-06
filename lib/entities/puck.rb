module Breakout
  class Puck < CyberarmEngine::GameObject
    attr_reader :box
    WIDTH = 16
    HEIGHT = 16

    def setup
      @speed = 5
      @color = Gosu::Color::GRAY
      @velocity.x = rand(@speed)
      @velocity.y = -@speed
      @velocity = @velocity.normalized

      @box = CyberarmEngine::BoundingBox.new
    end

    def draw
      draw_rect(@position.x, @position.y, WIDTH, HEIGHT, @color)
    end

    def update
      @position += @velocity * @speed
      update_box

      if @position.x <= 0
        @velocity.x *= -1
      end
      if @position.x >= window.width - WIDTH
        @velocity.x *= -1
      end

      if @position.y <= 0
        @velocity.y *= -1
      end
    end

    def update_box
      @box.min = @position
      @box.max = CyberarmEngine::Vector.new(@position.x + WIDTH, @position.y + HEIGHT)
    end
  end
end