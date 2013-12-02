class CreateTopicTags < ActiveRecord::Migration
  def change
    create_table :topic_tags do |t|
      t.references :topic
      t.references :tag
      t.timestamps
    end
  end
end
