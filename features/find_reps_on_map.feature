Feature: display US state representatives when you click on a county within a state

  As a person interested in politics 
  So that I can find out who represents my local county 
  And so that I can find out information about my representatives
  And so that I can learn about representatives in any US county
  I want to be able to search for my representative by:
    clicking on a state
    clicking on a county within that state
  When I click on that county I want to see a list of representatives for that county

Background: Given the following reps are in Polk County, OR 
  | name                   | ocdid | title          |
  | Bob Marley             | 1     | representative |
  | Micheal Jackson        | 2     | senator        |
  | Dwayne Johnson         | 3     | representative |

  And I am on the homepage


Scenario: find all represenatives in Polk County, Oregon
  When I click Oregon, OR
  And I click Polk County
  Then I should see the following representatives: Bob Marley, Micheal Jackson, Dwayne Johnson
  



