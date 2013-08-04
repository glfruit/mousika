package com.sanwn.mousika

import grails.plugin.spock.IntegrationSpec
import spock.lang.Shared

class CourseIntegrationSpec extends IntegrationSpec {

    @Shared fixtureLoader

    def setupSpec() {
        fixtureLoader['courseFixture'].load('CourseFixture')
    }

    def "create a valid new course"() {
        given: "user input valid course info"
        def course = new Course(title: 'a course', code: 'coursecode', startDate: new Date(), numberOfWeeks: 5)

        when: "the course is initiated"
        course.init()

        then:
        course.units.size() == 6
    }

    def "add a course member to course"() {
        setup:
        def fixture = fixtureLoader['courseFixture']
        def course = fixture.course
        def member = new CourseMember(user: fixture.user, role: fixture.role)

        when:
        course.addToCourseMembers(member)
        course.save(flush: true)

        then:
        course.id != null
        course.hasErrors() == false
        member.hasErrors() == false
        member.id != null
        member.user == fixture.user
        member.role == fixture.role
        member.course == course
    }

    def "find courses taught by user"() {
        setup:
        def fixture = fixtureLoader["courseFixture"]

        when:
        def c = Course.createCriteria()
        def owned = c.list {
            courseMembers {
                eq("user", fixture.user)
            }
        }

        then:
        owned != null
        owned.size() == 1

    }

    def "add new sections"() {
        setup:
        def course = new Course(code: "test", title: "test", startDate: new Date())
        def unit = new CourseUnit(sequence: 1, title: 'unit one')

        when:
        course.addToUnits(unit)
        course.save(flush: true)

        then:
        course.hasErrors() == false
        course.id != null
        course.units.size() == 1
        course.units[0].id != null
        course.units[0].sequence == 1
        course.units[0].title == 'unit one'
    }
}