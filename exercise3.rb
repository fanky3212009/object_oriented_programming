class Good
  attr_accessor :price, :basic_tax, :imported
  def initialize(good_description)
    @good_description = good_description
    @price = good_description[-5..-1].to_i
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
  attr_accessor :taxes, :total
  def initialize
    @sales_taxes = 0
    @total = 0
  end

  def calculate_tax_and_final(goods)
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

  def display(goods)
    goods.each do |good|
      puts good[0..-6].gsub(" at ", ": ") + good.final_price.to_s
    end
    puts "Sales Taxes: #{sales_taxes}"
    puts "Total: #{total}"
  end
end
