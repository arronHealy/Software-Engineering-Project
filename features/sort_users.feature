Feature: display list of users sorted by different criteria
 
  As an avid blogger
  So that I can quickly browse user profiles
  I want to see users sorted by oldest or newest

Background: users have been added to database

    Given the following users exist:
    | email            | password   | created_at | updated_at |
    | test1@mail.com   | password1  | 2016-05-25 | 2016-08-22 |
    | test2@mail.com   | password2  | 2017-06-25 | 2017-09-11 |
    | test3@mail.com   | password3  | 2018-05-25 | 2018-09-16 |
    | test4@mail.com   | password4  | 2019-03-11 | 2019-10-11 |
    | test5@mail.com   | password5  | 2019-05-11 | 2019-11-11 |
    | test6@mail.com   | password6  | 2020-02-10 | 2020-04-11 |

    And I am on the users page

Scenario: sort users by newest users
  When I follow "Sort By Newest Users"
  Then I should see user "test6@mail.com" before user "test5@mail.com"
  And I should see user "test5@mail.com" before user "test4@mail.com"
  And I should see user "test4@mail.com" before user "test3@mail.com"
  And I should see user "test3@mail.com" before user "test2@mail.com"
  And I should see user "test2@mail.com" before user "test1@mail.com"

  

Scenario: sort users by oldest users
  When I follow "Sort By Oldest Users"
  Then I should see user "test1@mail.com" before user "test2@mail.com"
  And I should see user "test2@mail.com" before user "test3@mail.com"
  And I should see user "test3@mail.com" before user "test4@mail.com"
  And I should see user "test4@mail.com" before user "test5@mail.com"
  And I should see user "test5@mail.com" before user "test6@mail.com"