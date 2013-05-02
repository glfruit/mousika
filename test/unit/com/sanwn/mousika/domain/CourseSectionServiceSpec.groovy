package com.sanwn.mousika.domain

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(CourseSectionService)
@Mock([Course, CourseSection, Content, Page])
class CourseSectionServiceSpec extends Specification {

    def "move content between two differenct sections"() {
        given:
        def course = new Course(code: 'code', title: "course", startDate: new Date()).save(failOnError: true)
        def section = new CourseSection(title: 'section1', sequence: 0, course: course).save(failOnError: true)
        3.times {
            def page = new Page(sequence: it, title: "page${it}", content: "Page Content", section: section).save(failOnError: true, flush: true)
            section.addToContents(page)
        }
        def sourceSize = section.contents.size()
        def targetSection = new CourseSection(title: 'section2', sequence: 1, course: course).save(failOnError: true)
        4.times {
            def page = new Page(sequence: it, title: "page${it}", content: "Page Content", section: targetSection).save(failOnError: true, flush: true)
            targetSection.addToContents(page)
        }
        def targetSize = targetSection.contents.size()
        def oldPos = 1
        def newPos = 2

        when:
        service.moveContentBetweenSections(course.id, section.sequence, targetSection.sequence, oldPos, newPos)

        then:
        section.contents.size() == sourceSize - 1
        targetSection.contents.size() == targetSize + 1
    }
}
