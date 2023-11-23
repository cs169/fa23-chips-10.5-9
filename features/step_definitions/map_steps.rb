Given /the following representatives are in "(.*)" County, "(.*)" / do |movies_table, county, state|
  reps_table.hashes.each do |rep|
    Representative.create!({ name: official.name, ocdid: ocdid_temp,
          title: title_temp })
  end
end

When /I click (.*)/ do |state|
  

Then /^I should see the following representatives: (.*)$/ do |representative_list|
  movies = representative_list.split(/\s*,\s*/).each do |representative|
    expect(page).to have_content(representative)
  end
end