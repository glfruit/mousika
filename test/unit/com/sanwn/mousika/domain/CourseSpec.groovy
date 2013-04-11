package com.sanwn.mousika.domain

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 *
 * @author glix
 * @version 1.0
 *
 */
@TestFor(Course)
class CourseSpec extends Specification {

    def "add a member to a course"() {
        setup:
        def user = mockFor(User)
        def role = mockFor(Role)
        def member = new CourseMember(user: user, role: role)
        def course = new Course(code: "code", title: "title", startDate: new Date())

        when:
        course.addToCourseMembers(member)

        and:
        course.save(flush: true)

        then:
        course.courseMembers.size() == 1
        member.id != null
        member.user == user
        member.role == role
    }
}
