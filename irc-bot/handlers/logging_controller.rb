class LoggingController < Marvin::CommandHandler
  
  exposes :listen, :earmuffs
  
  desc "Tells offbot to listen up again"
  def listen(data)
    target = options.target.to_s.downcase
    return unless target.present? && target == Marvin::Settings.target.to_s.downcase
    if Offlogger.logging_enabled
      reply "Logging is already enabled"
    else
      reply "I shall listen again"
      EM.next_tick { Offlogger.logging_enabled = true }
    end
  end
  
  desc "Tells offbot to stop listening"  
  def earmuffs(data)
    target = options.target.to_s.downcase
    return unless target.present? && target == Marvin::Settings.target.to_s.downcase
    if !Offlogger.logging_enabled
      reply "It's already disabled"
    else
      reply "I'm disabling logging, cap'n"
      EM.next_tick { Offlogger.logging_enabled = false }
    end
  end
  
end