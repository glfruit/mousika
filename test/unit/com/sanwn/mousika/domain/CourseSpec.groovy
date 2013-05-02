package com.sanwn.mousika.domain

import grails.test.mixin.Mock
import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestMixin(GrailsUnitTestMixin)
@Mock(Course)
class CourseSpec extends Specification {

    def "save a valid course"() {
        given: "a valid course"
        def course = new Course(code: 'code', title: "course", startDate: new Date())

        when: "the course is saved"
        course.save()

        then: "it should be saved successfully and be found"
        course.errors.errorCount == 0
        course.id != null
    }
}