# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  include Gravtastic
  gravtastic :rating => 'G', :size => 48, :secure => false
  
  has_many :topics, foreign_key: :author_id
  has_many :replies, foreign_key: :author_id
  has_one :profile

  before_create :build_profile

  def screen_name
    (profile.name.blank? || profile.name == name) ? name : "#{name}(#{profile.name})"
  end
end
