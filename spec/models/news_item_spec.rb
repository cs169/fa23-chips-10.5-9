# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItem, type: :model do
  let(:representative) { create(:representative) }

  before do
    @valid_news_item = described_class.new(issue: 'Free Speech', representative: representative)
    @invalid_news_item = described_class.new(issue: 'Invalid Issue', representative: representative)
  end

  it 'is valid with a valid issue' do
    expect(@valid_news_item).to be_valid
  end

  it 'is invalid with an invalid issue' do
    expect(@invalid_news_item).not_to be_valid
  end

  it 'sets the attribute correctly' do
    expect(@valid_news_item.issue).to eq('Free Speech')
  end

  it 'has an accessible issue attribute' do
    expect(@valid_news_item).to respond_to(:issue)
  end
end
