Marvin::Loader.before_run do
  Offlogger.register!
  KeikiThwopper.register!
  LoggingController.register!
end
