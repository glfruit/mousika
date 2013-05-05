package com.sanwn.mousika.controllers

import com.sanwn.mousika.domain.*
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
@Mock([Page, Course, CourseSection, Content])
class PageControllerSpec extends Specification {

    def "return to course page after page created successfully"() {
        given:
        def course = new Course(title: "title", code: "code", description: "description", startDate: new Date()).save()
        def section = new CourseSection(course: course, sequence: 0, title: "PageTest").save()
        course.addToSections(section)
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
