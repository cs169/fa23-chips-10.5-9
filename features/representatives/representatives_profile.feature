Feature: Representative Profile

As a user interested in the politics
I want to access information about a representative
So that I can stay informed about the political climate

Background:
  Given Kevin Yoder exists in the database

Scenario: Acess profile page
  Given Kevin Yoder exists in the database
  When I visit Kevin Yoder's profile
  Then I should see Kevin Yoder's name
  And I should see Kevin Yoder's OCD ID
  And I should see Kevin Yoder's office
  And I should see Kevin Yoder's address information
  And I should see Kevin Yoder's party
  And I should see Kevin Yoder's photo

Scenario: Access profile page from search
  Given I visit the search page
  When I search for Washington
  When I click on Patty Murray's link in the search results
  Then I should see Patty Murray's name
  And I should see Patty Murray's OCD ID
  And I should see Patty Murray's office
  And I should see Patty Murray's address information
  And I should see Patty Murray's party
  And I should see Patty Murray's photo