# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Visit New News Item Form', type: :feature do
  let(:representative) { create(:representative) }

  it 'User visits the new news item form' do
    visit representative_new_my_news_item_path(representative)

    expect(page).to have_selector('form.new_news_item')
    expect(page).to have_field('Title')
    expect(page).to have_field('Content')
    expect(page).to have_select('Issue')
  end
end
