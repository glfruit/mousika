Feature: New Course Entry
  As a teacher
  I want to create a new course
  so that students can register for it
  and I can teach it online

Scenario:
  Given I choose to create a new course
  When I add "Computer Networks"
  Then I see a new course page for "Computer Networks"