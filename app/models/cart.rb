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

  def subtotal
    cost = 0
    @items.each do |item|
     cost += item.price
    end
    cost 
  end

  def total
   ( subtotal * (1.0 + @tax_rate)).round 2 
  end

  def checkout!
    a = Invoice.create(user: @user, amount: total)
    
  end

end
