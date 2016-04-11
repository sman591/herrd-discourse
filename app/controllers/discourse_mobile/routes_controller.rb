module DiscourseMobile
  class RoutesController < ApplicationController

    before_filter :ensure_logged_in, except: [:verify_plugin]
    skip_before_filter :check_xhr, :preload_json
    skip_before_filter :redirect_to_login_if_required, only: :verify_plugin

    layout "no_ember"

    def index
      @api_key = api_key
      @login_url = mobile_login_url
    end

    def regenerate
      regenerate_api_key
      redirect_to :root
    end

    def login
      redirect_to mobile_login_url
    end

    def verify_plugin
      render json: { plugin_installed: true }
    end

    private

      def api_key
        key = ApiKey.find_by(user_id: current_user.id)
        if not key
          key = regenerate_api_key
        end
        key.key
      end

      def regenerate_api_key
        ApiKey.find_by(user_id: current_user.id).try(:destroy!)
        ApiKey.create(key: SecureRandom.hex(32), created_by: current_user, user: current_user)
      end

      def mobile_login_url
        "discoursemobile://auth/#{api_key}"
      end

  end
end
