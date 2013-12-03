# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  actived_at :datetime
#  edited_at  :datetime
#

class Topic < ActiveRecord::Base
  include Mentionable

  has_many :replies, dependent: :destroy
  has_many :topic_tags
  has_many :tags, through: :topic_tags
  belongs_to :user, as: :author

  before_create :set_actived_at

  scope :active, -> { order('actived_at desc') }

  def anchor
    "topic-#{id}"
  end

  def set_actived_at
    @actived_at = Time.now.utc
  end

  def set_edited_at
    @edited_at = Time.now.utc
  end

  def edited?
    edited_at.present?
  end

  def last_page
    page = (replies_count.to_f / self.class.default_per_page).ceil
    page > 1 ? page : nil
  end

  def replies_count
    self.replies.count
  end

  def relate_topics(count)
    Topic.active.joins(:tags).where('tags.name in ?', tags).limit(count).where.not(id: id)
  end
end
