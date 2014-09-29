class Watch < ActiveRecord::Base
  belongs_to :user
  belongs_to :item


  def watch_clean watch
    
  end
end
