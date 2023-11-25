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

When("I click on Patty Murray's link in the search results") do
  click_link('Patty Murray')
end

Then("I should see Patty Murray's name") do
  expect(page).to have_content('Patty Murray')
end

Then("I should see Patty Murray's OCD ID") do
  expect(page).to have_content('ocd-division/country:us/state:wa')
end

Then("I should see Patty Murray's office") do
  expect(page).to have_content('U.S. Senator')
end

Then("I should see Patty Murray's address information") do
  expect(page).to have_content('154 Russell Senate Office Building')
  expect(page).to have_content('Washington')
  expect(page).to have_content('DC')
  expect(page).to have_content('20510')
end

Then("I should see Patty Murray's party") do
  expect(page).to have_content('Democratic Party')
end

Then("I should see Patty Murray's photo") do
  expect(page).to have_css('img.img-fluid')
end
