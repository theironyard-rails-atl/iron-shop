class Item < ActiveRecord::Base
  validates_presence_of :title, :description, :price, :seller_id
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :seller, class_name: "User"

  # include Tire::Model::Search
  # include Tire::Model::Callbacks
  #
  # def self.search params
  #   tire.search(load: true) do
  #     query { string params[:query], default_operator: "AND" } if params[:query].present?
  #     binding.pry
  #   end
  # end

  include PgSearch
  pg_search_scope :search_item, :against => [:title, :description]
end
