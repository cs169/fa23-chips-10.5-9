# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'NewsItem Creation', type: :feature do
  let(:representative) { create(:representative) }

  it 'creates with valid issue' do
    visit representative_new_my_news_item_path(representative)

    fill_in 'Title', with: 'Article on Climate Change'
    select 'Climate Change', from: 'Issue'
    click_button 'Create News Item'

    expect(page).to have_text('Climate Change')
  end
end
