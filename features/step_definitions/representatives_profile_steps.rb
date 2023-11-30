# frozen_string_literal: true

Given('Kevin Yoder exists in the database') do
  Representative.create!(
    name:   'Kevin Yoder',
    ocdid:  'ocdid1',
    title:  'Mayor',
    street: '215 Cannon HOB',
    city:   'Washington',
    state:  'DC',
    zip:    '20515',
    party:  'Republican',
    photo:  'http://yoder.house.gov/images/user_images/headshot.jpg'
  )
end

When("I visit Kevin Yoder's profile") do
  rep = Representative.find_by(name: 'Kevin Yoder')
  visit representative_path(rep)
end

Then("I should see Kevin Yoder's name") do
  expect(page).to have_content('Kevin Yoder')
end

Then("I should see Kevin Yoder's OCD ID") do
  expect(page).to have_content('ocdid1')
end

Then("I should see Kevin Yoder's office") do
  expect(page).to have_content('Mayor')
end

Then("I should see Kevin Yoder's address information") do
  expect(page).to have_content('215 Cannon HOB')
  expect(page).to have_content('Washington')
  expect(page).to have_content('DC')
  expect(page).to have_content('20515')
end

Then("I should see Kevin Yoder's party") do
  expect(page).to have_content('Republican')
end

Then("I should see Kevin Yoder's photo") do
  expect(page).to have_css('img.img-fluid')
end

Given('I visit the search page') do
  visit '/representatives/'
end

When('I search for Washington') do
  fill_in 'address', with: 'Washington'
  click_button 'Search'
end

When("I click on Joseph R. Biden's link in the search results") do
  click_link('Joseph R. Biden')
end

Then("I should see Joseph R. Biden's information") do
  expect(page).to have_content('Joseph R. Biden')
  expect(page).to have_content('ocd-division/country:us')
  expect(page).to have_content('President of the United States')
  expect(page).to have_content('1600 Pennsylvania Avenue Northwest')
  expect(page).to have_content('Washington')
  expect(page).to have_content('DC')
  expect(page).to have_content('20500')
  expect(page).to have_content('Democratic Party')
end

Given('Joseph R. Biden exists in the database') do
  Representative.create!(
    name:   'Joseph R. Biden',
    ocdid:  'ocd-division/country:us',
    title:  'President of the United States',
    street: '1600 Pennsylvania Avenue Northwest',
    city:   'Washington',
    state:  'DC',
    zip:    '20500',
    party:  'Democratic Party'
  )
end

Given('I visit the news item page for Joseph R. Biden') do
  rep = Representative.find_by(name: 'Joseph R. Biden')
  visit "/representatives/#{rep.id}/news_items"
end

# When("I click on Joseph R. Biden's name") do
#   click_link('Joseph R. Biden')
# end
