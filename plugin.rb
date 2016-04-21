# name: herrd
# about: Connects your Discourse forum to the Herrd mobile app
# version: 0.1.0
# authors: Stuart Olivera
# url: https://github.com/herrd/herrd-discourse

enabled_site_setting :herrd_enabled

if ENV['RUN_COVERAGE']
  gem 'codeclimate-test-reporter', '0.5.0', require: nil
end


# load the engine
load File.expand_path('../lib/herrd.rb', __FILE__)
load File.expand_path('../lib/herrd/engine.rb', __FILE__)
load File.expand_path('../lib/herrd/exceptions.rb', __FILE__)
load File.expand_path('../lib/herrd/notifier.rb', __FILE__)

after_initialize do

  Notification.class_eval do
    after_commit :send_to_herrd, on: :create

    def send_to_herrd
      Jobs.enqueue(:herrd_notifier, notification_id: id)
    end
  end

end
