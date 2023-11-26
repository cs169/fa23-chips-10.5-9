# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do
  let(:representative) { create(:representative) }
  let(:news_item) { create(:news_item, representative: representative) }

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

  describe '#news_item_params' do
    it 'permits trusted parameters' do
      params = ActionController::Parameters.new(news_item: { title: 'Title', description: 'Description' })
      controller.params = params
      expect(controller.send(:news_item_params)).to eq(params.require(:news_item).permit(:title, :description))
    end
  end
end
