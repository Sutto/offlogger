module ApplicationHelper
  
  def grouped_by_author_and_type(events = @events)
    items = []
    buffer = []
    last_nick, last_type = nil, nil
    events.each do |event|
      nick, type = event.nick_id, event.name
      if nick != last_nick || type != last_type
        last_nick = nick
        last_type = type
        items << buffer unless buffer.empty?
        buffer = [event]
      else
        buffer << event
      end
    end
    items << buffer unless buffer.empty?
    return items
  end
  
  def grouped_by_period(events = @events, spacing = 1.day)
    period = spacing.to_i
    items = events.group_by do |event|
      (event.occured_at.to_i / period).round * period
    end
    items.map { |period, items| ["Starting #{time_ago_in_words(Time.at(period))} ago", items]}
  end
  
end
