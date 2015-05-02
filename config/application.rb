require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "rails/test_unit/railtie"
require 'sprockets/railtie'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module PersonalWebsite
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en

    # Do not swallow errors in after_commit/after_rollback callbacks.
    Mongoid.logger.level = Logger::DEBUG
    Moped.logger.level = Logger::DEBUG

    # Active Job Step
    config.active_job.queue_adapter = :sidekiq
    config.active_job.queue_name_prefix = Rails.env

    # Mailer
    config.action_mailer.delivery_method = :sendmail
    config.action_mailer.sendmail_settings = {  
        :location       => '/usr/sbin/sendmail',  
        :arguments      => '-i -t'  
    }
    config.consider_all_requests_local = true

    # mailer previews
    config.action_mailer.show_previews = true
    config.action_mailer.preview_path = "#{Rails.root}/lib/mailer_previews"
#    config.action_mailer.smtp_settings = {
#      address:              'smtpcloud.sohu.com',
#      port:                 25,
#      domain:               'bdfzer.com',
#      user_name:            'alumni_bdfzer',
#      password:             'PdMi5kvH7PkNdLmc',
#      authentication:       'login'
#      #enable_starttls_auto: true
#    }
    Rack::MiniProfiler.config.position = 'right'
  end
end

require "markdown"
