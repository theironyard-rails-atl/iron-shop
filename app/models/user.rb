class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_many :bought_items, through: :invoice, source: :items
  has_many :sold_items, source: :items
  has_many :invoices
  ROLES= %i[shopper seller admin]
end
