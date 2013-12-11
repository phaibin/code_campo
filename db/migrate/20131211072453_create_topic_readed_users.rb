class CreateTopicReadedUsers < ActiveRecord::Migration
  def change
    create_table :topic_readed_users do |t|
      t.references :topic, index: true
      t.references :user, index: true
      t.timestamps
    end
  end
end
