# == Schema Information
#
# Table name: users
#
#  id                  :integer         not null, primary key
#  login               :string(255)
#  crypted_password    :string(255)
#  password_salt       :string(255)
#  persistence_token   :string(255)
#  single_access_token :string(255)
#  perishable_token    :string(255)
#  login_count         :integer
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  display_name        :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  type                :string(255)
#  slug                :string(255)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should_have_many :nicks
  should_have_many :events, :through => :nicks

end
