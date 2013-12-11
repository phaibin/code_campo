# == Schema Information
#
# Table name: replies
#
#  id         :integer          not null, primary key
#  author_id  :integer
#  topic_id   :integer
#  created_at :datetime
#  updated_at :datetime
#  content    :string(255)
#

class Reply < ActiveRecord::Base
  belongs_to :topic
  belongs_to :author, class_name: 'User'
end
