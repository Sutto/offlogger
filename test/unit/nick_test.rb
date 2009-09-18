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

require 'test_helper'

class NickTest < ActiveSupport::TestCase

  should_have_many :events
  should_belong_to :user
  
end
