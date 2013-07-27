package com.sanwn.mousika

import grails.buildtestdata.mixin.Build
import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(CourseService)
@Build([Course, CourseUnit, Content, Page])
class CourseServiceSpec extends Specification {

    def "move seciton to another position"() {
        given:
        def course = Course.build().save(flush: true)
        if (course.hasErrors()) {
            throw new RuntimeException("Error initializing")
        }
        def unit = CourseUnit.build(course: course).save(failOnError: true, flush: true)
        if (unit.hasErrors()) {
            throw new RuntimeException("Error initializing")
        }
        2.times {
            unit.addToItems(Page.build(sequence: it)).save(failOnError: true, flush: true)
            if (unit.hasErrors()) {
                throw new RuntimeException("Error initializing")
            }
        }
        def targetSection = CourseUnit.build(sequence: 1, course: course).save(failOnError: true, flush: true)
        3.times {
            targetSection.addToItems(Page.build(sequence: it)).save(failOnError: true, flush: true)
        }
        def lastSection = CourseUnit.build(sequence: 2, course: course).save(failOnError: true, flush: true)
        4.times {
            lastSection.addToItems(Page.build(sequence: it)).save(failOnError: true, flush: true)
        }
        def oldSeq = unit.sequence
        def newSeq = targetSection.sequence

        when:
        service.moveSection(unit, targetSection)

        then:
        unit.sequence == newSeq
        unit.items.size() == 2
        targetSection.sequence == oldSeq
        targetSection.items.size() == 3
        lastSection.sequence == 2

    }
}
