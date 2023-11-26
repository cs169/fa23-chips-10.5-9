# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItemsController, type: :controller do
  let(:representative) { create(:representative) }
  let(:news_item) { create(:news_item, representative: representative) }

  describe 'GET #index' do
    it 'assigns @news_items and renders the index template' do
      get :index, params: { representative_id: representative.id }
      expect(assigns(:news_items)).to eq(representative.news_items)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns @news_item and renders the show template' do
      get :show, params: { representative_id: representative.id, id: news_item.id }
      expect(assigns(:news_item)).to eq(news_item)
      expect(response).to render_template(:show)
    end
  end

  describe '#set_representative' do
    it 'assigns @representative' do
      controller.params[:representative_id] = representative.id
      controller.send(:set_representative)
      expect(assigns(:representative)).to eq(representative)
    end
  end

  describe '#set_news_item' do
    it 'assigns @news_item' do
      controller.params[:id] = news_item.id
      controller.send(:set_news_item)
      expect(assigns(:news_item)).to eq(news_item)
    end
  end
end
