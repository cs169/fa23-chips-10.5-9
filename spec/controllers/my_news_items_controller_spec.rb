# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do
  let(:news_item) { create(:news_item, representative: representative) }

  describe '#news_item_params' do
    it 'permits trusted parameters' do
      params = ActionController::Parameters.new(news_item: { title: 'Title', description: 'Description',
issue: 'Free Speech' })
      controller.params = params
      expect(controller.send(:news_item_params)).to eq(params.require(:news_item).permit(:title, :description, :issue))
    end
  end
end
