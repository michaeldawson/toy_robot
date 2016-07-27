class Robot
  VALID_X_COORDINATES = 0..4.freeze
  VALID_Y_COORDINATES = 0..4.freeze
  VALID_DIRECTIONS = %w(NORTH SOUTH EAST WEST).freeze

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

  def report
    puts position_to_s(x, y, direction)
  end

  def position_to_s(x, y, direction)
    "X: #{x}, Y: #{y}, F: #{direction}"
  end
end
