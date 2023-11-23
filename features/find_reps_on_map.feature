Feature: display US state representatives when you click on a county within a state

  As a person interested in politics 
  So that I can find out who represents my local county 
  And so that I can find out information about my representatives
  And so that I can learn about representatives in any US county
  I want to be able to search for my representative by:
    clicking on a state
    clicking on a county within that state
  When I click on that county I want to see a list of representatives for that county

Background: I am on the homepage


Scenario: find all represenatives in Polk County, Oregon
  When I click the state of OR
  And I click the county of Polk in OR
  Then I should see the following representatives: Joseph R. Biden,	Kamala D. Harris, Jeff Merkley, Ron Wyden, Tina Kotek, Christina E. Stephenson, LaVonne Griffin-Valade	
  And I should see the following representatives: Ellen F. Rosenblum,	Tobias Read, Aruna A. Masih, Bronson D. James
	And I should see the following representatives: Christopher L. Garrett, Meagan A. Flynn, Rebecca A. Duncan, Roger J. DeHoog, Stephen K. Bushong,
  And I should see the following representatives: Kim Williams, Valerie Patoine, Steve Milligan, Mark Garton, Aaron Felton, Craig Pope, Jeremy Gordon, Lyle Mordhorst	
  



