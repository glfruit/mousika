Feature: login to system
  As a user of the system
  I want to login to system
  so that I can do something userful

  Scenario: login with valid username and password
    Given I open login page
    When I input username "admin" and password "admin"
    Then I see course list