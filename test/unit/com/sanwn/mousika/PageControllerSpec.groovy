package com.sanwn.mousika

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 *
 * @author glix
 * @version 1.0
 *
 */
@TestFor(PageController)
@Mock([Page, Course, CourseUnit, Content])
class PageControllerSpec extends Specification {

    def "return to course page after page created successfully"() {
        given:
        def course = new Course(title: "title", code: "code", description: "description", startDate: new Date()).save()
        def section = new CourseUnit(course: course, sequence: 0, title: "PageTest").save()
        course.addToUnits(section)
        params.courseId = course.id
        params.sectionSeq = 0
        params.title = "Page title"
        params.content = "Page content"
        params.returnToCourse = "true"

        when:
        controller.save()

        then:
        response.redirectedUrl == "/course/show/${course.id}"
    }
}
