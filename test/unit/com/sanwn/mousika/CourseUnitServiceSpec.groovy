package com.sanwn.mousika

import grails.buildtestdata.mixin.Build
import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(CourseUnitService)
@Build([Course, CourseUnit, Content, Page])
class CourseUnitServiceSpec extends Specification {

    def "move content between two differenct sections"() {
        given:
        def course = Course.build().save(failOnError: true, flush: true)
        def section = CourseUnit.build(course: course).save(failOnError: true, flush: true)
        3.times {
            section.addToItems(Page.build(sequence: it)).save(failOnError: true, flush: true)
        }
        def sourceSize = section.items.size()
        def targetSection = CourseUnit.build(sequence: 1, course: course).save(failOnError: true, flush: true)
        4.times {
            targetSection.addToItems(Page.build(sequence: it)).save(failOnError: true, flush: true)
        }
        def targetSize = targetSection.items.size()
        def oldPos = 1
        def newPos = 2

        when:
        service.moveContentBetweenSections(course.id, section.sequence, targetSection.sequence, oldPos, newPos)

        then:
        section.items.size() == sourceSize - 1
        targetSection.items.size() == targetSize + 1
    }
}
