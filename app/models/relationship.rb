class Relationship < ActiveRecord::Base
  belongs_to :item
  belongs_to :invoice

end
