# == Schema Information
#
# Table name: topic_marked_users
#
#  id         :integer          not null, primary key
#  topic_id   :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_topic_marked_users_on_topic_id  (topic_id)
#  index_topic_marked_users_on_user_id   (user_id)
#

class TopicMarkedUser < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
end
