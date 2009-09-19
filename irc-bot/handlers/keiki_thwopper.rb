class KeikiThwopper < Marvin::Base
  
  FROM_REGEXP  = /^(keiki)/i
  THWOP_REGEXP = /(t+h+w+o+m*p+)/i
  
  MESSAGES = [
    "mwahahahaha",
    "you totally deserved it",
    "oi! leave 'em alone!",
    "say hello to my little friend",
    "you know, they could have liked that?"
  ]
  
  on_event :incoming_action,  :thwop_back
  
  def thwop_back
    target = options.target.to_s.downcase
    return unless target.present? && target == Marvin::Settings.target.to_s.downcase
    return if !from || from !~ FROM_REGEXP || options.message !~ THWOP_REGEXP
    action "#{$1}s #{from} (#{MESSAGES[rand(MESSAGES.length)]})"
  end
  
end