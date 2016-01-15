class Rover
  attr_accessor :x_coordinate, :y_coordinate, :direction

  def initialize(x_coordinate, y_coordinate, direction)
    @x_coordinate = x_coordinate
    @y_coordinate = y_coordinate
    @direction = direction
  end

  def read_instruction(instruction)
    instruction == "M" ? move : turn(instruction)
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

# Take it Further!
class MissionControl
  def read_instructions(instructions, rover)
    instructions.each_char { |chr| rover.read_instruction(chr)}
  end

  def report(rover)
    puts "#{rover.x_coordinate} #{rover.y_coordinate} #{rover.direction}"
  end
end

class Plateau
  def initialize(x_size, y_size)
    @x_size = x_size
    @y_size = y_size
  end

  def off?(rover)
    rover.x_coordinate < 0 || rover.x_coordinate > x_size && \
    rover.y_coordinate < 0 && rover.y_coordinate > y_size
  end

  def collision?(rover1, rover2)
    rover1.x_coordinate == rover2.x_coordinate && \
    rover1.y_coordinate == rover2.y_coordinate
  end
  
end
