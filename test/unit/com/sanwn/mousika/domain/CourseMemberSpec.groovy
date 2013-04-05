package com.sanwn.mousika.domain

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 *
 * @author glix
 * @version 1.0
 *
 */
@TestFor(CourseMember)
class CourseMemberSpec extends Specification {

    def "create a new member for a course"() {
        setup:
        def user = mockFor(User)
        def role = mockFor(Role)
        def course = new Course(code: "code", title: "title", startDate: new Date())

        when:
        def member = new CourseMember(user: user, role: role)
        course.addToCourseMembers(member)

        then:
        member.user != null
        member.role != null
        member.hasErrors() == false
    }
}
