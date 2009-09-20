class ActivityController < ApplicationController
  
  def index
    @events = Event.paginate :per_page => 100, :page => params[:page], :include => {:nick => :user}
  end
  
  def search
  end
  
  def user
    @events = Event.paginate :per_page => 100, :page => params[:page], :include => {:nick => :user}
  end
  
  def context
  end
  
end
