class Cart
  def initialize shopper, options = {}
    @tax_rate = options[:tax_rate] || 0.04
    @subtotal = 0
    @cart = []
    @shopper = shopper
  end

  def add item
    @cart << item
    @subtotal = @subtotal + item.price
  end

  def tax_rate
    @tax_rate
  end

  def items
    @cart
  end

  def subtotal
    @subtotal
  end

  def total
    @total = @subtotal * ( 1 + @tax_rate )
  end

  def remove

  end

  def checkout!
    invoice = @shopper.invoices.new
    @cart.each do |item|
      invoice << item
    end
    invoice.amount = self.total
    invoice.save!
  end
end
