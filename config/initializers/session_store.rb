# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_offlogger_session',
  :secret      => 'af26a4d568da70ab19eef578e95ce0beea41c5e13de8a3459a0bce515c3f3fd3a0badbccc2309019c5b9ce06c93e8bdbf963fc9b948efc65d4350fb30c578e99'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
