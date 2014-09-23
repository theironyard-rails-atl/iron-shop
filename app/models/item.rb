class Item < ActiveRecord::Base
  validates_presence_of :title, :description, :price, :seller_id
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :seller, class_name: "User"
end
