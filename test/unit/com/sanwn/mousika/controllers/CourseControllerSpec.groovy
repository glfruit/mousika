package com.sanwn.mousika.controllers

import com.sanwn.mousika.domain.*
import grails.plugin.gson.test.GsonUnitTestMixin
import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import grails.test.mixin.TestMixin
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestFor(CourseController)
@TestMixin(GsonUnitTestMixin)
@Mock([Course, CourseSection, Role, User, CourseMember])
class CourseControllerSpec extends Specification {

    def "should add a valid course"() {

    }

    def "should fail with an invalid course"() {
        setup:
        messageSource.addMessage("date.startDate.format", Locale.default, "yyyy-MM-dd")
        request.addPreferredLocale(Locale.default)

        when:
        controller.save()

        then:
        view == '/course/create'
        model.title == null
    }

    def "should list members of a course"() {
        setup:
        def role = new Role(name: Role.TEACHER).save(validate: false)
        def user = new User(username: "glix").save(validate: false)
        user.addToRoles(role)
        def course = new Course(title: "title", code: "code", description: "description", startDate: new Date()).save()
        def member = new CourseMember(user: user, role: role).save(validate: false)
        course.addToCourseMembers(member).save(flush: true, validate: false)

        when:
        controller.listMembers(course.id)

        then:
        response.json[0].roles[0].name == "教师"
    }
}