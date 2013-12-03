# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Site < ActiveRecord::Base
  has_one :fragment
  after_initialize :build_fragment_if_nil

  def build_fragment_if_nil
    build_fragment if fragment.nil?
  end
end
