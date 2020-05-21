Feature: display list of articles sorted by different criteria
 
  As an avid blogger
  So that I can quickly browse articles based on my preferences
  I want to see articles sorted by oldest or newest

Background: articles have been added to database

    Given the following articles exist:
    | title         | description           | creator      | created_at | updated_at |
    | test title1   | testing description1  | Arron Healy  | 2016-05-25 | 2016-08-22 |
    | test title2   | testing description2  | John Doe     | 2017-06-25 | 2017-09-11 |
    | test title3   | testing description3  | Jane Doe     | 2018-05-25 | 2018-09-16 |
    | test title4   | testing description4  | Mick Mac     | 2019-03-11 | 2019-10-11 |
    | test title5   | testing description5  | John Doe     | 2019-05-11 | 2019-11-11 |
    | test title6   | testing description6  |              | 2020-02-10 | 2020-04-11 |

    And I am on the articles page

Scenario: sort articles by newest articles
  When I follow "Sort By Newest"
  Then I should see "test title6" before "test title5"
  And I should see "test title5" before "test title4"
  And I should see "test title4" before "test title3"
  And I should see "test title3" before "test title2"
  And I should see "test title2" before "test title1"

  

Scenario: sort articles by oldest articles
  When I follow "Sort By Oldest"
  Then I should see "test title1" before "test title2"
  And I should see "test title2" before "test title3"
  And I should see "test title3" before "test title4"
  And I should see "test title4" before "test title5"
  And I should see "test title5" before "test title6"