# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  
  config.gem "haml", :version => ">= 2.1"
  config.gem 'chriseppstein-compass', :lib => 'compass', :source => 'http://gems.github.com'
  
  config.gem 'authlogic', :version => ">= 2.0"
  config.gem 'searchlogic', :version => ">= 2.0"
  
  config.gem 'justinfrench-formtastic', :lib => 'formtastic', :source => 'http://gems.github.com'
  config.gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gems.github.com', :version => '>= 2.2.3'

  # config.load_paths += %W( #{RAILS_ROOT}/extras )
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
  
  config.time_zone = 'UTC'
  
end