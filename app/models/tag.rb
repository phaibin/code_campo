# == Schema Information
#
# Table name: tags
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  index_value :integer          default(0)
#

class Tag < ActiveRecord::Base
  has_many :topic_tags
  has_many :topics, through: :topic_tags

  def self.suggest_tags(limit = 500)
    self.order([[:index_value]]).limit(limit).map(&:id)
  end
end
