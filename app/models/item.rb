# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  price       :float
#  seller_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Item < ActiveRecord::Base
  validates_presence_of :title, :description, :price, :seller_id
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :seller, class_name: "User"
  has_many :carts, through: :cart_items
  has_many :cart_items

  include PgSearch
  pg_search_scope :search, against: [:title, :description],
    using: { tsearch: { dictionary: "english" } }

  def self.text_search(query)
    if query.present?
      where("title @@ :q or description @@ :q", q: query)
    else
      all
    end
  end
end
