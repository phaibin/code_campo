# == Schema Information
#
# Table name: topic_tags
#
#  id         :integer          not null, primary key
#  topic_id   :integer
#  tag_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

class TopicTag < ActiveRecord::Base
  belongs_to :topic
  belongs_to :tag
end
