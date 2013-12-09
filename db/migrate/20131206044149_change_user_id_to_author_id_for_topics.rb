class ChangeUserIdToAuthorIdForTopics < ActiveRecord::Migration
  def change
    change_table :topics do |t|
      t.rename :user_id, :author_id
    end
  end
end
