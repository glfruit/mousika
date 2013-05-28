package com.sanwn.mousika

import com.sanwn.mousika.domain.Course
import com.sanwn.mousika.domain.CourseMember
import com.sanwn.mousika.domain.CourseSection
import grails.plugin.spock.IntegrationSpec
import org.springframework.transaction.annotation.Transactional

class CourseIntegrationSpec extends IntegrationSpec {

    def fixtureLoader

    def "add a course member to course"() {
        setup:
        def fixture = fixtureLoader.load("CourseFixture")
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
        def fixture = fixtureLoader.load("CourseFixture")
        when:
        def owned = Course.findAll {
            fixture.course.courseMembers == fixture.user
        }

        then:
        owned != null
        owned.size() == 1

    }

    def "add new sections"() {
        setup:
        def course = new Course(code: "test", title: "test", startDate: new Date())
        def section = new CourseSection(sequence: 1, title: 'section one')

        when:
        course.addToSections(section)
        course.save(flush: true)

        then:
        course.hasErrors() == false
        course.id != null
        course.sections.size() == 1
        course.sections[0].id != null
        course.sections[0].sequence == 1
        course.sections[0].title == 'section one'
    }
}