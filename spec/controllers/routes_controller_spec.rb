require "./plugins/herrd-discourse/spec/rails_helper"

describe Herrd::RoutesController do

  routes { Herrd::Engine.routes }

  shared_examples_for 'the login page' do
    context 'without a logged in user' do
      it 'redirects to login page' do
        get :login
        is_expected.to redirect_to('/login')
      end
    end

    context 'with a logged in user' do
      before do
        log_in(:admin)
      end

      it 'displays link to app' do
        get :login
        expect(response.status).to eq(200)
      end
    end
  end

  describe '#verify_plugin' do
    context 'without a logged in user' do
      it 'loads plugin info' do
        get :verify_plugin
        expect(JSON.parse(response.body)).to eq({ "plugin_installed" => true })
      end
    end
  end

  describe '#login' do
    context 'without login_required enabled' do
      before do
        SiteSetting.login_required = false
      end

      it_behaves_like 'the login page'
    end

    context 'with login_required enabled' do
      before do
        SiteSetting.login_required = true
      end

      it_behaves_like 'the login page'
    end
  end

end
