module Breakout
  class Game < CyberarmEngine::GuiState
    def setup
      stack(width: 1.0, height: 1.0, z: -100) do
        background Gosu::Color::BLACK
      end

      @bricks = []
      @columns = 12
      @rows = 3

      build_level

      @paddle = Paddle.new(x: window.width / 2 - Paddle::WIDTH / 2, y: window.height - (Paddle::HEIGHT + 1))
      @puck   = Puck.new
      @puck.position.x = window.width / 2 - Puck::WIDTH / 2
      @puck.position.y = @paddle.position.y - (Puck::HEIGHT + 1)
    end

    def build_level
      @rows.times do |y|
        @columns.times do |x|
          @bricks << Brick.new(x: 1 + x * Brick::WIDTH + x, y: 1 + y * Brick::HEIGHT + y)
        end
      end
    end

    def update
      if @puck.position.y > window.height
        push_state(GameOver)
      elsif @bricks.size == 0
        push_state(GameWon)
      end

      super

      destroy_bricks

      bounce_puck_off(@paddle)
    end

    def destroy_bricks
      intersections = @bricks.select do |brick|
        brick.box.intersect?(@puck.box)
      end

      intersections.each do |brick|
        bounce_puck_off_brick(brick)

        @bricks.delete(brick)
        @game_objects.delete(brick)
      end
    end

    # TODO: Add support for Y axis
    def bounce_puck_off(object)
      if @puck.box.intersect?(object.box)
        # World space puck and object center on X axis
        puck_center = @puck.position.x + Puck::WIDTH / 2
        object_center = object.position.x + object.class::WIDTH / 2

        # Object local center on X axis
        center = object_center - object.position.x

        # X axis distance from world space puck and object center points
        distance = puck_center - object_center

        # X axis bounce direction
        value = (distance / center).abs.clamp(0.0, 0.9)

        @puck.velocity.x = distance < 0 ? -value : value
        @puck.velocity.y = -1 # Always bounce in fixed direction instead of using *= -1

        @puck.velocity = @puck.velocity.normalized
      end
    end

    def bounce_puck_off_brick(brick)
      edges = {top: false, left: false, right: false, bottom: false}

      # https://gamedev.stackexchange.com/a/24091
      wy = (Puck::WIDTH + Brick::WIDTH)   * ((@puck.position.y - Puck::HEIGHT) - (brick.position.y - Brick::HEIGHT / 2));
      hx = (Puck::HEIGHT + Brick::HEIGHT) * ((@puck.position.x - Puck::WIDTH)  - (brick.position.x - Brick::HEIGHT / 2));

      if (wy > hx)
        if (wy > -hx)
          edges[:bottom] = true
        else
          edges[:left] = true
        end
      else
        if (wy > -hx)
          edges[:right] = true
        else
          edges[:top] = true
        end
      end

      if edges[:top]
        @puck.velocity.y = -1
      elsif edges[:bottom]
        @puck.velocity.y = 1
      end

      if edges[:left]
        @puck.velocity.x *= -1
      elsif edges[:right]
        @puck.velocity.x *= -1
      end
    end
  end
end