package com.sanwn.mousika

import com.sanwn.mousika.domain.Course
import com.sanwn.mousika.domain.CourseSection
import com.sanwn.mousika.domain.CourseSectionService
import com.sanwn.mousika.domain.Page
import grails.buildtestdata.mixin.Build
import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(CourseSectionService)
@Build([Course, CourseSection, Content, Page])
class CourseSectionServiceSpec extends Specification {

    def "move content between two differenct sections"() {
        given:
        def course = Course.build().save(failOnError: true, flush: true)
        def section = CourseSection.build(course: course).save(failOnError: true, flush: true)
        3.times {
            section.addToContents(Page.build(sequence: it)).save(failOnError: true, flush: true)
        }
        def sourceSize = section.contents.size()
        def targetSection = CourseSection.build(sequence: 1, course: course).save(failOnError: true, flush: true)
        4.times {
            targetSection.addToContents(Page.build(sequence: it)).save(failOnError: true, flush: true)
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
