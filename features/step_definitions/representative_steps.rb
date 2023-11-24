Given('the system already has a representative with the following attributes:') do |table|
  table.hashes.each do |row|
    Representative.create!(name: row['name'], ocdid: row['ocdid'], title: row['title'])
  end
end

Given('new representative data given as:') do |table|
  @new_representative_data = table.hashes.first
end

When('I submit this data') do 
  @initial_count = Representative.count
  Representative.find_or_create_by(@new_representative_data)
end

Then('a new representative should not be created') do
  expect(Representative.count).to eq(@initial_count)
end

Then('the number of representatives should increase by {int}') do |int|
  expect(Representative.count).to eq(@initial_count + int)
end
