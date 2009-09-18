require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should_have_many :nicks
  should_have_many :events, :through => :nicks

end
