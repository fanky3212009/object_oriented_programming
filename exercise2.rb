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
  attr_accessor :x_size, :y_size

  def initialize(x_size, y_size)
    @x_size = x_size
    @y_size = y_size
  end

  def off?(rover)
    rover.x_coordinate < 0 || rover.x_coordinate > x_size || \
    rover.y_coordinate < 0 || rover.y_coordinate > y_size
  end

  def collision?(rover1, rover2)
    rover1.x_coordinate == rover2.x_coordinate && \
    rover1.y_coordinate == rover2.y_coordinate
  end

end

main = MissionControl.new
puts "INPUT AND OUTPUT\n\n"
puts "Input the Plateau size,"
plateau_sizes = gets.chomp.split()
plateau_x_size = plateau_sizes[0].to_i
plateau_y_size = plateau_sizes[1].to_i
plateau = Plateau.new(plateau_x_size, plateau_y_size)
puts "Input the first rover's initial position"
first_coordinates = gets.chomp.split()
rover1 = Rover.new(first_coordinates[0].to_i, first_coordinates[1].to_i, first_coordinates[2])
puts "Input the first rover's instructions"
instructions = gets.chomp
main.read_instructions(instructions, rover1)
while plateau.off?(rover1)
  puts "Off! Re-input the first rover's instructions"
  rover1 = Rover.new(first_coordinates[0].to_i, first_coordinates[1].to_i, first_coordinates[2])
  instructions = gets.chomp
  main.read_instructions(instructions, rover1)
end

puts "Input the second rover's initial position"
second_coordinates = gets.chomp.split()
rover2 = Rover.new(second_coordinates[0].to_i, second_coordinates[1].to_i, second_coordinates[2])
puts "Input the second rover's instructions"
instructions = gets.chomp
main.read_instructions(instructions, rover2)
while plateau.off?(rover2) || plateau.collision?(rover1, rover2)
  puts "Off!/Collision! Re-input the second rover's instructions"
  rover2 = Rover.new(second_coordinates[0].to_i, second_coordinates[1].to_i, second_coordinates[2])
  instructions = gets.chomp
  main.read_instructions(instructions, rover2)
end

puts "\n\n"
puts"First rover's final coordinates:"
main.report(rover1)
puts"Second rover's final coordinates:"
main.report(rover2)
