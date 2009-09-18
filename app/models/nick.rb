# == Schema Information
#
# Table name: nicks
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Nick < ActiveRecord::Base
  
  has_many   :events
  belongs_to :user

  def self.[](name)
    first(:conditions => ["LOWER(nicks.name) = ?", name.downcase]) || create(:name => name)
  end
  
end
