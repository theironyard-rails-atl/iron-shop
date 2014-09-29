class AddNotifiedToWatch < ActiveRecord::Migration
  def change
    add_column :watches, :notified, :boolean, default: false
  end
end
