# config/initializers/clamby.rb
Clamby.configure do |config|
  config.daemonize = true
  config.silence_output = false
end
