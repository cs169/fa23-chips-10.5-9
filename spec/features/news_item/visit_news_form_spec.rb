# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Visit New News Item Form', type: :feature do
  let(:representative) { create(:representative) }
  let(:user) { create(:user, provider: 'google_oauth2', uid: '123') }

  before do
    visit login_path
    click_on 'Sign in with Google'
    visit representative_new_my_news_item_path(representative)
  end

  it 'User visits the new news item form' do
    expect(page).to have_selector('form')
    expect(page).to have_select('Representative')
    expect(page).to have_select('Issue')
  end
end
