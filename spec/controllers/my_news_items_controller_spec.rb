# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do
  let(:representative) { create(:representative) }
  let(:news_item) { create(:news_item, representative: representative) }
  let(:user) { create(:user, provider: 'google_oauth2', uid: '123') }

  before do
    session[:current_user_id] = user.id
  end

  describe '#news_item_params' do
    it 'permits trusted parameters' do
      params = ActionController::Parameters.new(news_item: { title: 'Title', description: 'Description' })
      controller.params = params
      expect(controller.send(:news_item_params)).to eq(params.require(:news_item).permit(:title, :description))
    end
  end

  describe 'GET #list' do
    it 'renders the list template' do
      get :list, params: { news_item: { representative_id: representative.id, title: 'SomeTitle' } }
      expect(response).to render_template(:list)
    end
  end
end
