# == Schema Information
#
# Table name: fragments
#
#  id                    :integer          not null, primary key
#  home_mainbar_bottom   :string(255)
#  home_sidebar_bottom   :string(255)
#  topics_sidebar_bottom :string(255)
#  footer                :string(255)
#  site_id               :integer
#  created_at            :datetime
#  updated_at            :datetime
#

class Fragment < ActiveRecord::Base
  belongs_to :site
end
