class Cart_Item < ActiveRecord::Base
  belongs_to :cart
  belongs_to :item
end
