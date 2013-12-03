class AddActivedAtAndEditedAtToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :actived_at, :datetime
    add_column :topics, :edited_at, :datetime
  end
end
