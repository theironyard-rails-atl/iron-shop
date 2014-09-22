class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :items, foreign_key: 'seller_id'
  has_many :invoices, foreign_key: 'shopper_id'
  # has_and_belongs_to_many :invoices
end
