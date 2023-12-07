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
    context 'when params are passed' do
      news_item = ActionController::Parameters.new(representative_id: '1', ratings: ['3'])
      params = ActionController::Parameters.new(title: 'Title', description: 'Description', link: 'link',
                                                issue: 'Free Speech', news_item: news_item)
      it 'permits trusted parameters and creates news item hash' do
        controller.params = params
        expect(controller.send(:news_item_params)).to eq({ description: 'Description', issue: 'Free Speech',
link: 'link', representative_id: '1', title: 'Title' })
      end
    end
  end

  describe 'GET #list' do
    it 'renders the list template' do
      get :list, params: { news_item:         { representative_id: representative.id, issue: 'Free Speech' },
                           representative_id: representative.id }
      expect(response).to render_template(:list)
    end
  end

  describe '#set_selected_rep_and_issue' do
    context 'when news_item parameters are present' do
      news_item = ActionController::Parameters.new(representative_id: 1, ratings: ['3'],
                                                   issue: 'Free Speech')
      it 'sets @selected_representative and @selected_issue' do
        controller.params = ActionController::Parameters.new(title: 'Title', description: 'Description', link: 'link',
                                                             news_item: news_item, representative_id: representative.id)
        controller.send(:set_selected_rep_and_issue)

        expect(controller.instance_variable_get(:@selected_representative_id)).to eq(1)
        expect(controller.instance_variable_get(:@selected_issue)).to eq('Free Speech')
      end
    end
  end
end
