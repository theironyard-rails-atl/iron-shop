class Cart
  attr_accessor :items, :tax_rate
  def initialize user
   @user = user
   @items = []
   @tax_rate = 0.04
  end 

  def add item 
    @items << item
  end

  def remove item 
    @items.pop item
  end

  def clear
    @items = []
  end

  def subtotal
    @items.reduce(0) do |total,item|
      total +=  item.price
      total 
    end
  end

  def total
   ( subtotal * (1.0 + @tax_rate)).round 2 
  end

  def checkout!
    Invoice.create(user: @user, amount: total)
  end

end
