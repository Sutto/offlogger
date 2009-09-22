class ActivityController < ApplicationController
  
  def index
    @events = Event.ordered.paginate :per_page => 100, :page => params[:page], :include => {:nick => :user}
  end
  
  def search
  end
  
  def user
    @events = Event.ordered.paginate :per_page => 100, :page => params[:page], :include => {:nick => :user}
  end
  
  def context
  end
  
end
