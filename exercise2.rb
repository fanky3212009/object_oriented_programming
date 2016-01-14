class Rover
  attr_accessor :x_coordinate, :y_coordinate, :direction

  def initialize(x_coordinate, y_coordinate, direction)
    @x_coordinate = x_coordinate
    @y_coordinate = y_coordinate
    @direction = direction
  end

  def read_instruction(instruction)
    instruction.each_char {|char| char == "M" ? move : turn(char)}
  end

  def move
    case direction
    when "N"
      @y_coordinate += 1
    when "S"
      @y_coordinate -= 1
    when "W"
      @x_coordinate -= 1
    when "E"
      @x_coordinate += 1
    end
  end

  def turn(char)
    direction_array = ["N", "E", "S", "W"]
    direction_index = direction_array.index(direction)
    if char == "L"
      direction_index = (direction_index - 1) % 4
    else # char == "R"
      direction_index = (direction_index + 1) % 4
    end
    @direction = direction_array[direction_index]
  end
end
