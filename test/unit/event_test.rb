# == Schema Information
#
# Table name: events
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  message    :text
#  occured_at :datetime
#  nick_id    :integer
#  created_at :datetime
#  updated_at :datetime
#


require 'test_helper'

class EventTest < ActiveSupport::TestCase
  
  should_belong_to :nick

  should_validate_presence_of :occured_at

  should 'default occured at'
  
  should 'let you automagically create a nick with raw_nick='
  
  should 'provide an action helper'
  
  should 'provide an message helper'
  
  should 'provide an join helper'
  
  should 'provide an part helper'
  
  should 'provide an quit helper'

end
