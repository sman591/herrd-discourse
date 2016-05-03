module Herrd
  class RoutesController < ::ApplicationController

    before_filter :herrd_redirect_to_login_if_required, only: :login
    skip_before_filter :redirect_to_login_if_required, only: :login

    before_filter :ensure_logged_in, except: [:verify_plugin]
    skip_before_filter :check_xhr, :preload_json

    layout "no_ember"

    def index
      @api_key = api_key
      @login_url = herrd_login_url
    end

    def regenerate
      regenerate_api_key
      redirect_to :root
    end

    def login
      @login_url = herrd_login_url
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

      def herrd_login_url
        "herrd://auth?api_key=#{api_key}&username=#{current_user.username}"
      end

      def herrd_redirect_to_login_if_required
        return if current_user || (request.format.json? && api_key_valid?)

        if SiteSetting.enable_sso?
          # save original URL in a session so we can redirect after login
          session[:destination_url] = destination_url
          redirect_to path('/session/sso')
        else
          # save original URL in a cookie (javascript redirects after login in this case)
          cookies[:destination_url] = destination_url
          redirect_to path('/login')
        end
      end

  end
end
