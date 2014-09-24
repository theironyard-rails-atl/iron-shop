class Cart
  attr_accessor :items, :tax_rate

  def initialize shopper, opts={}
    @shopper = shopper
    @tax_rate = 0.04
    @items = if opts[:item_ids]
      Item.find(opts[:item_ids])
    else
      []
    end
  end


  def add item
    @items << item
  end

  def subtotal
    @items.map{ |item| item.price }.reduce(:+)
  end

  def total
    (subtotal * (1 + @tax_rate)).to_f.round(2)
  end

  def checkout!
    invoice = Invoice.new(user: @shopper, amount: self.total)
    invoice.save!
  end

end