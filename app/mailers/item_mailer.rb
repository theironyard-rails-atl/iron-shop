class ItemMailer < ActionMailer::Base
  default from: 'pricewatch@iron-shop.example.com'
  def price_watch item, user
    @item = item
    @user = user
    mail to: @user.email, subject: "PriceWatch Message for: #{@item.item.title}"
  end
end
