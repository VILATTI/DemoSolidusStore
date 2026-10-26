# frozen_string_literal: true

Devise.secret_key = '5373261eaf5c1e8c922d2ce02e014228a29593b1dde824b6ef99c042183db624f8865ad013ef70ea4c2c0620125c43ac1979a971f35f67d4de160cbdfd03d7fb'
Devise.email_regexp = Spree::Config.default_email_regexp
Devise.setup do |config|
  config.parent_controller = 'StoreDeviseController'
  config.mailer = 'UserMailer'
end
