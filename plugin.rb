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

after_initialize do

  on(:post_created) do |post|

  end

end
