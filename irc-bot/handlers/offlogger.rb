class Offlogger < Marvin::Base
  
  cattr_accessor :logging_enabled
  self.logging_enabled = true
  
  on_event :client_connected, :setup_connection!
  on_event :reloaded,         :setup_connection!
  
  [:message, :action, :quit, :part, :join].each do |event|
    
    on_event :"incoming_#{event}" do
      record! :incoming, event, :message
    end
    
    on_event :"outgoing_#{event}" do
      record! :outgoing, event, :message
    end
    
  end
  
  def record!(type, name, options_key)
    return unless @@logging_enabled
    target = options.target.to_s.downcase
    return unless target.present? && target == Marvin::Settings.target.to_s.downcase
    with_connection do
      user = (type == :outgoing ? client.nickname : from)
      Event.send(name, user, options.send(options_key)) if user.present?
    end
  end
  
  def setup_connection!
    self.class.load_rails unless defined?(Rails)
  end
  
  def self.load_rails
    logger.info "Loading Rails."
    require Pathname(__FILE__).dirname.dirname.dirname.join("config", "environment")
    ActiveRecord::Base.logger = Marvin::Logger.logger
    logger.info "Rails loaded."
  end
  
  def with_connection
    ActiveRecord::Base.connection.verify!
    yield
  end
  
end