# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#  access_token    :string(255)
#  locale          :string(255)      default("zh-CN")
#

class User < ActiveRecord::Base
  include ActiveModel::SecurePassword
  include Gravtastic

  gravtastic :rating => 'G', :size => 48, :secure => false

  has_secure_password

  attr :current_password
  
  has_many :topics, foreign_key: :author_id
  has_many :replies, foreign_key: :author_id
  has_one :profile

  before_create :build_profile, :set_access_token

  def screen_name
    (profile.name.blank? || profile.name == name) ? name : "#{name}(#{profile.name})"
  end

  def set_access_token
    self.access_token ||= generate_token
  end

  def generate_token
    SecureRandom.hex(32)
  end

  def admin?
    APP_CONFIG['admin_emails'].include?(self.email)
  end
end
