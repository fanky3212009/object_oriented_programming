class Good
  attr_accessor :good_description, :price, :basic_tax, :imported, :tax, :final_price
  def initialize(good_description)
    @good_description = good_description
    @price = good_description[-5..-1].strip.to_f
    @basic_tax = true
    if good_description.include?("book") ||
      good_description.include?("chocolate") ||
      good_description.include?("pills")
      @basic_tax = false
    end
    @imported = good_description.include?("imported")
    @tax = 0
    @final_price = 0
  end
end


class Receipt
  attr_accessor :input, :goods, :sales_taxes, :total
  def initialize(input)
    @input = input
    @goods = []
    input_array = input.split("\n")
    input_array.each {|good_description| @goods << Good.new(good_description)}
    @sales_taxes = 0
    @total = 0
  end

  def calculate_tax_and_final
    goods.each do |good|
      good.tax += good.price * 0.1 if good.basic_tax
      good.tax += good.price * 0.05 if good.imported
      @sales_taxes += good.tax
      good.final_price = (good.price + good.tax).round(2)
      @total += good.final_price
    end
    @sales_taxes = sales_taxes.round(2)
    @total = total.round(2)
  end

  def display
    goods.each do |good|
      puts good.good_description[0..-6].gsub(" at", ":") + good.final_price.to_s
    end
    puts "Sales Taxes: #{sales_taxes}"
    puts "Total: #{total}"
  end
end

puts "INPUT:\n\n"

input1 = "1 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85"

input2 = "1 imported box of chocolates at 10.00
1 imported bottle of perfume at 47.50"

input3 = "1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
1 box of imported chocolates at 11.25"

puts "Input 1:\n#{input1}\n\n"
puts "Input 2:\n#{input2}\n\n"
puts "Input 3:\n#{input3}\n\n"

puts "OUTPUT:\n\n"

receipt1 = Receipt.new(input1)
receipt1.calculate_tax_and_final

receipt2 = Receipt.new(input2)
receipt2.calculate_tax_and_final

receipt3 = Receipt.new(input3)
receipt3.calculate_tax_and_final

puts "Output 1:\n"
puts "#{receipt1.display}\n\n"
puts "Output 2:\n"
puts "#{receipt2.display}\n\n"
puts "Output 3:\n"
puts "#{receipt3.display}\n\n"
