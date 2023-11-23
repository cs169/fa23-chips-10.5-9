# frozen_string_literal: true

# Use 2 letter state symbols here

Then /^I click the state of (.*)$/ do |state|
  path = "/state/#{state}"
  visit path
end

Then /^I click the county of (.*) in (.*)$/ do |county, state|
  path = "/search/#{county}%20County,%20#{state}?from_state_map=true"
  visit path
end

Then /^I should see the following representatives: (.*)$/ do |representative_list|
  representative_list.split(/\s*,\s*/).each do |representative|
    expect(page).to have_content(representative)
  end
end
