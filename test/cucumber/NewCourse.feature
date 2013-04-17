Feature: new course entry
  As an administrator
  I want to add a new course
  so that teachers could add resources

  Scenario: new course
    Given I login with valid username "admin" and password "admin"
    And I open the create course page
    When I add a course:
    | code  |        title      |  startDate | numberOfWeeks |
    | 86793 | Computer Networks | 2013-09-01 |      6        |
    Then I see enroll member page for "Computer Networks"