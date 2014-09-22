class Item < ActiveRecord::Base
  belongs_to :seller, class_name: "User", foreign_key: "user_id"
  belongs_to :invoice
  validates_presence_of :title, :price, :seller
  validates :price,  numericality: {greater_than_or_equal_to: 0}
end
