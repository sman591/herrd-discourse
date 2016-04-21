# name: discourse-mobile
# about: Adds support for Discourse mobile apps
# version: 0.1.0
# authors: Stuart Olivera
# url: https://github.com/sman591/discourse-mobile

enabled_site_setting :mobile_enabled

if ENV['RUN_COVERAGE']
  gem 'codeclimate-test-reporter', '0.5.0', require: nil
end


# load the engine
load File.expand_path('../lib/discourse_mobile.rb', __FILE__)
load File.expand_path('../lib/discourse_mobile/engine.rb', __FILE__)
load File.expand_path('../lib/discourse_mobile/exceptions.rb', __FILE__)
load File.expand_path('../lib/discourse_mobile/notifier.rb', __FILE__)

after_initialize do

  Notification.class_eval do
    after_commit :send_to_herrd, on: :create

    def send_to_herrd
      Jobs.enqueue(:herrd_notifier, notification_id: id)
    end
  end

end
