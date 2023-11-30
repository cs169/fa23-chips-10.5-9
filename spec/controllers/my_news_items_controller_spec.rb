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
      params = ActionController::Parameters.new(news_item: { title: 'Title', description: 'Description',
issue: 'Free Speech' })
      controller.params = params
      expect(controller.send(:news_item_params)).to eq(params.require(:news_item).permit(:title, :description, :issue))
    end
  end

  describe 'GET #list' do
    it 'renders the list template' do
      get :list, params: { representative_id: representative.id, issue: 'Climate Change' }
      expect(response).to render_template(:list)
    end
  end

  describe '#set_selected_rep_and_issue' do
    context 'when news_item parameters are present' do
      it 'sets @selected_representative and @selected_issue' do
        params = { news_item: { representative_id: representative.id, issue: news_item.issue } }
        controller.params = ActionController::Parameters.new(params)

        controller.send(:set_selected_rep_and_issue)

        expect(controller.instance_variable_get(:@selected_representative)).to eq(representative.name)
        expect(controller.instance_variable_get(:@selected_issue)).to eq(news_item.issue)
      end
    end

    context 'when news_item parameters are not present' do
      it 'sets @selected_representative and @selected_issue to nil' do
        params = {}
        controller.params = ActionController::Parameters.new(params)

        controller.send(:set_selected_rep_and_issue)

        expect(controller.instance_variable_get(:@selected_representative)).to be_nil
        expect(controller.instance_variable_get(:@selected_issue)).to be_nil
      end
    end
  end
end
