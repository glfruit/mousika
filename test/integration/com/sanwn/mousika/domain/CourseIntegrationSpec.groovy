package com.sanwn.mousika.domain

import grails.plugin.spock.IntegrationSpec

class CourseIntegrationSpec extends IntegrationSpec {

    def "add a course member to course"() {
        setup:
        def user = new User(username: "un", passwordHash: "pwd", fullname: "full", email: "e@g.com").save()
        def role = new Role(name: "rl").save()
        def course = new Course(code: "code", title: "title", startDate: new Date()).save()
        def member = new CourseMember(user: user, role: role)

        when:
        course.addToCourseMembers(member)
        course.save(flush: true)

        then:
        course.hasErrors() == false
        member.hasErrors() == false
        member.user == user
        member.role == role
        member.course == course
    }

    def "find courses taught by user"() {
        setup:
        def user = new User(username: "un", passwordHash: "pwd", fullname: "full", email: "e@g.com").save()
        def role = new Role(name: "rl").save()
        def course = new Course(code: "code", title: "title", startDate: new Date()).save()
        def member = new CourseMember(user: user, role: role)

        when:
        course.addToCourseMembers(member)
        course.save(flush: true)

        then:
        def owned = Course.findAll {
            courseMembers.user == user
        }
        owned != null
        owned.size() == 1

    }

    def "add new sections"() {
        setup:
        def course = new Course(code: "test", title: "test",startDate: new Date())
        def section = new CourseSection(sequence: 1,title: 'section one')

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