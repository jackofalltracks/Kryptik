Clearance.configure do |config|
  config.cookie_expiration = lambda { 1.year.from_now.utc }
  config.secure_cookie = false
  config.mailer_sender = 'thefounder@detroitrails.co'
  config.password_strategy = Clearance::PasswordStrategies::BCrypt
  config.user_model = User
  config.redirect_url = '/'
end
