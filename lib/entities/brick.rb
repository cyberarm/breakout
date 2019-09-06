module Breakout
  class Brick < CyberarmEngine::GameObject
    attr_reader :box
    WIDTH = 64
    HEIGHT = 32

    def setup
      @color = Gosu::Color.rgb(73, rand(255), 90)

      @box = CyberarmEngine::BoundingBox.new(@position, CyberarmEngine::Vector.new(@position.x + WIDTH, @position.y + HEIGHT))
    end

    def draw
      draw_rect(@position.x, @position.y, WIDTH, HEIGHT, @color)
    end
  end
end