require 'circular_list'

class Robot
  VALID_X_COORDINATES = 0..4.freeze
  VALID_Y_COORDINATES = 0..4.freeze
  VALID_DIRECTIONS = %w(NORTH EAST SOUTH WEST).freeze

  attr_accessor :x, :y, :direction

  def self.valid_position?(x, y, direction)
    VALID_X_COORDINATES.include?(x) && VALID_Y_COORDINATES.include?(y) && VALID_DIRECTIONS.include?(direction)
  end

  def place(x, y, direction)
    raise "Invalid position: #{position_to_s(x, y, direction)}" unless self.class.valid_position?(x, y, direction)

    @x = x
    @y = y
    @direction = direction
  end

  def move
    self.x += x_delta
    self.y += y_delta
  end

  def left
    self.direction = directions.fetch_before(direction)
  end

  def right
    self.direction = directions.fetch_after(direction)
  end

  def report
    puts position_to_s(x, y, direction)
  end

  private

  def position_to_s(x, y, direction)
    "X: #{x}, Y: #{y}, F: #{direction}"
  end

  def x_delta
    delta[0]
  end

  def y_delta
    delta[1]
  end

  def delta
    case direction
    when 'NORTH' then [0, 1]
    when 'EAST' then [1, 0]
    when 'SOUTH' then [0, -1]
    when 'WEST' then [-1, 0]
    end
  end

  def directions
    @directions ||= CircularList::List.new(VALID_DIRECTIONS.dup)
  end
end
