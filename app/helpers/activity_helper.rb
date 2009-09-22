module ActivityHelper
  
  def formatted_nick(nick)
    text = "&lt;#{h(nick.name)}&gt;"
    if nick.user
      link_to text, user_path(nick.user)
    else
      text
    end
  end
  
  def formatted_event(event)
    render :partial => "events/#{event.name}", :locals => {:event => event}
  end
  
end
