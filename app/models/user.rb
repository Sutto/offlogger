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

class User < ActiveRecord::Base
  include SimpleSlugs
  self.slug_source = :display_name
  
  acts_as_authentic
  
  has_many :nicks
  has_many :events, :through => :nicks
  
  
  validates_presence_of :display_name, :on => :create, :message => "can't be blank"
  
  def self.[](login)
    first(:conditions => ["LOWER(users.login) = ?", login.downcase])
  end
  
  def can(action, object)
    object.respond_to?(:"can_#{action}?") && object.send(:"can_#{action}?", self)
  end
  
  def can_edit?(other)
    self == other
  end
  
  def can_destroy?(other)
    self == other
  end
  
end
