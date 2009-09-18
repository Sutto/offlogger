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

class Event < ActiveRecord::Base
  
  def self.[](id, *args)
    find(id, *args)
  end
  
  belongs_to :nick
  
  validates_presence_of :name
  
  before_save :default_occured_at
  
  ## Helpers for the logger
  class << self
    %w(action message join quit part).each do |type|
      define_method(type) do |nick, contents|
        create!(:raw_nick => nick, :name => type, :message => contents)
      end
    end
  end
  ## End Helpers for the logger
  
  def raw_nick=(value)
    self.nick = Nick[value]
  end
  
  protected
  
  def default_occured_at
    self.occured_at ||= Time.now
  end
  
end
