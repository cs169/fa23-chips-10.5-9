# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItem, type: :model do
  let(:representative) { create(:representative) }

  it 'is valid with a valid issue' do
    news_item = described_class.new(issue: 'Free Speech', representative: representative)
    expect(news_item).to be_valid
  end

  it 'is invalid with an invalid issue' do
    news_item = described_class.new(issue: 'Invalid Issue', representative: representative)
    expect(news_item).not_to be_valid
  end
end
