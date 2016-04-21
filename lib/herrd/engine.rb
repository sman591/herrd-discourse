module Herrd
  class Engine < ::Rails::Engine
    isolate_namespace Herrd

    initializer('herrd',
                after: :load_config_initializers) do |app|
      Rails.application.routes.prepend do
        mount Herrd::Engine, at: '/herrd'
      end
    end
  end
end
