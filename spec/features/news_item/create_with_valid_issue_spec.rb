# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'NewsItem Creation', type: :feature do
  let(:representative) { create(:representative) }
  let(:user) { create(:user, provider: 'google_oauth2', uid: '123') }

  before do
    visit login_path
    click_on 'Sign in with Google'
    visit representative_new_my_news_item_path(representative)
  end

  it 'creates with valid issue' do
    select 'Kevin Yoder', from: 'Representative'
    select 'Climate Change', from: 'Issue'
    click_button 'Search'

    expect(page).to have_text('Kevin Yoder')
    expect(page).to have_text('Climate Change')
  end
end
