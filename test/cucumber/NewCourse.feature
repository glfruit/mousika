@ignore
Feature: new course entry
  As an administrator
  I want to add a new course
  so that teachers could add resources

  Scenario: new course
    Given I login with valid username and password
    And I open the create course page
    When I add "Computer Networks"
    Then I see enroll member page