Feature: logging a user into the application
 
  As an avid blogger
  So that I can quickly browse the web site
  I want to log in to the application

Background: users have been added to database

    Given the following users exist:
    | email            | password   | created_at | updated_at |
    | test1@mail.com   | password1  | 2016-05-25 | 2016-08-22 |
    | test2@mail.com   | password2  | 2017-06-25 | 2017-09-11 |
    | test3@mail.com   | password3  | 2018-05-25 | 2018-09-16 |
    | test4@mail.com   | password4  | 2019-03-11 | 2019-10-11 |
    | test5@mail.com   | password5  | 2019-05-11 | 2019-11-11 |
    | test6@mail.com   | password6  | 2020-02-10 | 2020-04-11 |

    And I am on the login page

Scenario: Successful login to application
    When I fill in "Email" with "test1@mail.com"
    And I fill in "Password" with "password1"
    And I press "Login"
    Then I should be on the user profile page for "test1@mail.com"
    And I should see "Logged in successfully!"


Scenario: Unsuccessful login to application
    When I fill in "Email" with "test1@mail.com"
    And I fill in "Password" with "password2"
    And I press "Login"
    Then I should be on the login page
    And I should see "Error! Unsuccessful Login. Please try again!"