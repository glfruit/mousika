package com.sanwn.mousika

import grails.buildtestdata.mixin.Build
import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 *
 * @author glix
 * @version 1.0
 *
 */
@TestFor(PageController)
@Build([Page, Course, CourseUnit, Content])
class PageControllerSpec extends Specification {

    def "return to course page after page created successfully"() {
        given:
        def course = new Course(title: "title", code: "code", description: "description", startDate: new Date()).save()
        def unit = new CourseUnit(course: course, sequence: 0, title: "PageTest").save()
        course.addToUnits(unit)
        params.courseId = course.id
        params.sectionSeq = 0
        params.title = "Page title"
        params.content = "Page content"
        params.returnToCourse = "true"
        def pageService = mockFor(PageService)
        pageService.demand.createPage {
            id, seq, page -> Page.build()
        }
        controller.pageService = pageService.createMock()

        when:
        controller.save()

        then:
        response.redirectedUrl == "/course/show/${course.id}"
    }
}
