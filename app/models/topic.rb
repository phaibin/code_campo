class Topic < ActiveRecord::Base
  has_many :replies, dependent: :destroy
  has_many :topic_tags
  has_many :tags, through: :topic_tags
  belongs_to :user
end
