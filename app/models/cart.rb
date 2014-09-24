class Cart < ActiveRecord::Base

  has_many :carts_items
  has_many :items, through: :carts_items
  belongs_to :shopper, class_name: "User"

  def add item
    @cart = CartItem.new
  end

  def items
    @cart
  end

  def subtotal
    @subtotal
  end

  def total
    @total = @subtotal * ( 1 + @tax_rate )
    @total.round(2)
  end

  def remove

  end

  def checkout!
    invoice = @shopper.invoices.new
    @cart.each do |item|
      invoice.items << item
    end
    invoice.amount = self.total
    invoice.save!
  end
end
