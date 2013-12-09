class ChangeUserIdToAuthorIdForReply < ActiveRecord::Migration
  def change
    rename_column :replies, :user_id, :author_id
  end
end
