class Item < ActiveRecord::Base
  belongs_to :seller, class_name: 'User'

  validates_presence_of :price, :seller, :title

  validate :price_is_positive

private

  def price_is_positive
    if price && price <= 0
      errors.add :price, 'must be positive'
    end
  end
end
