Feature: Representative Creation

As a system administrator
I want to ensure that no duplicates are created
So that database integrity is maintained

Background:
  Given the system already has a representative with the following attributes:
    | name | ocdid | title |
    | John Marston | Armadillo | Sheriff |

Scenario: No duplicates are created
  Given new representative data given as:
    | name | ocdid | title |
    | John Marston | Armadillo | Sheriff |
  When I submit this data
  Then a new representative should not be created

Scenario: A different representative is created
  Given new representative data given as:
    | name | ocdid | title |
    | Jack Marston | Blackgate | Deputy |
  When I submit this data
  Then the number of representatives should increase by 1