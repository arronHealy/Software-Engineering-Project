Feature: signing a user up for the application
 
  As an avid blogger
  So that I can gain access to the web site
  I want to sign up for the application

Background: users have been added to database

    Given the following users exist:
    | email            | password   | created_at | updated_at |
    | test1@mail.com   | password1  | 2016-05-25 | 2016-08-22 |
    | test2@mail.com   | password2  | 2017-06-25 | 2017-09-11 |
    | test3@mail.com   | password3  | 2018-05-25 | 2018-09-16 |
    | test4@mail.com   | password4  | 2019-03-11 | 2019-10-11 |
    | test5@mail.com   | password5  | 2019-05-11 | 2019-11-11 |
    | test6@mail.com   | password6  | 2020-02-10 | 2020-04-11 |

    And I am on the signup page

Scenario: Successful signup to the application
    When I fill in "Email" with "test7@mail.com"
    And I fill in "Password" with "password7"
    And I press "Sign up"
    Then I should be on the login page
    And I should see "You have Successfully Signed up. Please Login to access Wiki-Blog"


Scenario: Unsuccessful signup to the application
    When I fill in "Email" with "test8"
    And I fill in "Password" with "password8"
    And I press "Sign up"
    Then I should be on the signup page
    And I should see "Sign up failed! You have entered invalid credentials."