class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :invoices
  has_many :items_for_sale, class: Item
  has_many :watches, dependent: :destroy
  has_many :items, through: :watches

  def watch_notifications
    @watches = []
    Watch.where(user_id: self.id).includes(:item).each do |watch|
      if watch.price >= watch.item.price
        @watches << watch
      end
    end
    return @watches
  end

end
