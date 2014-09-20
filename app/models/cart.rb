class Cart
  attr_accessor :tax_rate
  attr_reader :items

  def initialize user
    @user, @items, @tax_rate = user, [], 0.04
  end

  def add item
    @items.push item
  end

  def subtotal
    @items.map(&:price).reduce(&:+).round 2
  end

  def total
    (subtotal * (1 + tax_rate)).round 2
  end

  def checkout!
    invoice = @user.invoices.create! amount: total
    @items.each { |item| invoice.items << item }
    invoice
  end
end
