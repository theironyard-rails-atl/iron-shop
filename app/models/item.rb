# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  price       :float
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  invoice_id  :integer
#

class Item < ActiveRecord::Base
  belongs_to :seller, class_name: "User", foreign_key: "user_id"
  belongs_to :invoice
  has_many :watched_items
  validates_presence_of :title, :price, :seller
  validates :price,  numericality: {greater_than_or_equal_to: 0}
  include PgSearch
  # multisearchable if searching through different Models
  # multisearchable :against => :title
  pg_search_scope :search_by_item, :against => [:title, :description]
end
