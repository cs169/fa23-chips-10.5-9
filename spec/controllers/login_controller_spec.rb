# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  let(:user) { create(:user, provider: 'google_oauth2', uid: '123') }

  describe 'GET #login' do
    it 'renders the login template' do
      get :login
      expect(response).to render_template(:login)
    end

    it 'redirects to user profile if already logged in' do
      session[:current_user_id] = user.id
      get :login
      expect(response).to redirect_to(user_profile_path)
    end
  end

  describe 'GET #logout' do
    it 'clears current_user_id from session and redirects to root_path' do
      session[:current_user_id] = user.id
      get :logout
      expect(session[:current_user_id]).to be_nil
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'private methods' do
    let(:user_info) { OmniAuth.config.mock_auth[:google_oauth2] }

    describe '#find_or_create_user' do
      it 'finds an existing user' do
        user = create(:user, provider: 'google_oauth2', uid: user_info['uid'])
        found_user = controller.send(:find_or_create_user, user_info, :create_google_user)
        expect(found_user).to eq(user)
      end
    end

    describe '#create_google_user' do
      let(:google_user_attributes) do
        {
          uid:        user_info['uid'],
          provider:   User.providers[:google_oauth2],
          first_name: user_info['info']['first_name'],
          last_name:  user_info['info']['last_name'],
          email:      user_info['info']['email']
        }
      end

      it 'creates a new Google user' do
        allow(User).to receive(:create)
        controller.send(:create_google_user, user_info)
        expect(User).to have_received(:create).with(google_user_attributes)
      end
    end

    describe '#create_github_user' do
      let(:split_github_user) do
        {
          uid:        user_info['uid'],
          provider:   User.providers[:github],
          first_name: 'John',
          last_name:  'Doe',
          email:      user_info['info']['email']
        }
      end

      it 'creates a new GitHub user with name split into first and last name' do
        user_info['info']['name'] = 'John Doe'
        allow(User).to receive(:create)
        controller.send(:create_github_user, user_info)
        expect(User).to have_received(:create).with(split_github_user)
      end
    end

    describe '#already_logged_in' do
      it 'redirects to user profile if already logged in' do
        session[:current_user_id] = user.id
        allow(controller).to receive(:redirect_to)
        controller.send(:already_logged_in)
        expect(controller).to have_received(:redirect_to).with(user_profile_path, notice: anything)
      end

      it 'does not redirect if not logged in' do
        allow(controller).to receive(:redirect_to)
        controller.send(:already_logged_in)
        expect(controller).not_to have_received(:redirect_to)
      end
    end
  end
end
