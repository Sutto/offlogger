require 'test_helper'

class NickTest < ActiveSupport::TestCase

  should_have_many :events
  should_belong_to :user
  
end
