Feature: search for articles by creator

   As an avid blogger
   So I can find articles by my favourite creators
   I want to search on creator information on articles I enter

Background: ensure articles in database

    Given the following articles exist:
    | title         | description           | creator      | created_at | updated_at |
    | test title1   | testing description1  | Arron Healy  | 2016-05-25 | 2016-08-22 |
    | test title2   | testing description2  | John Doe     | 2017-06-25 | 2017-09-11 |
    | test title3   | testing description3  | Jane Doe     | 2018-05-25 | 2018-09-16 |
    | test title4   | testing description4  | Mick Mac     | 2019-03-11 | 2019-10-11 |
    | test title5   | testing description5  | John Doe     | 2019-05-11 | 2019-11-11 |
    | test title6   | testing description6  |              | 2020-02-10 | 2020-04-11 |

Scenario: add creator to existing article
  When I go to the edit page for "test title6"
  And  I fill in "Creator" with "Arron Healy"
  And  I press "Update Article"
  Then the creator of "test title6" should be "Arron Healy"


Scenario: find article with same creator
  Given I am on the details page for "test title2"
  When  I follow "Find Articles With Same Creator"
  Then  I should be on the similar articles page for "test title2"
  And   I should see "test title5"
  But   I should not see "test title6"


Scenario: can't find similar articles if we don't know creator (sad path)
  Given I am on the details page for "test title6"
  Then  I should not see "Arron Healy"
  When  I follow "Find Articles With Same Creator"
  Then  I should be on the articles page
  And   I should see "'test title6' has no creator info"