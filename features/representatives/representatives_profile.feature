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
  When I click on Joseph R. Biden's link in the search results
  Then I should see Joseph R. Biden's information