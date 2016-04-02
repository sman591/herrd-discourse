module DiscourseMobile
  class Engine < ::Rails::Engine
    isolate_namespace DiscourseMobile

    initializer('discourse_mobile',
                after: :load_config_initializers) do |app|
      Rails.application.routes.prepend do
        mount DiscourseMobile::Engine, at: '/mobile'
      end
    end
  end
end
