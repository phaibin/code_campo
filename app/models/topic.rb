# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  author_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  actived_at :datetime
#  edited_at  :datetime
#

class Topic < ActiveRecord::Base
  # include Mentionable

  has_many :replies, dependent: :destroy
  has_many :topic_tags
  has_many :tags, through: :topic_tags
  belongs_to :author, class_name: 'User'
  has_many :topic_marked_users
  has_many :marked_users, through: :topic_marked_users, source: :user
  has_many :topic_readed_users
  has_many :readed_users, through: :topic_readed_users, source: :user

  before_create :set_actived_at

  scope :active, -> { order('actived_at desc') }

  def tag_string=(string)
    self.tags = string.to_s.downcase.split(/[,\s]+/).uniq
  end

  def tag_string
    self.tags.join(', ')
  end

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
    Topic.active.joins(:tags).where('tags.name in (?)', self.tags.map(&:name)).where.not(id: id).limit(count)
  end

  # mark begin
  def mark_by(user)
    unless marked_by? user
      marked_users << user
    end
  end

  def unmark_by(user)
    if marked_by? user
      marked_users.delete user
    end
  end

  def marked_by?(user)
    marked_users.include? user
  end

  def marker_count
    marked_users.count
  end
  # mark end

  def last_read?(user)
    readed_users.include? user
  end

  def read_by(user)
    unless last_read?(user)
      readed_users << user
    end
  end
end
