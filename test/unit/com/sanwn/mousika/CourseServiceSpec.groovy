package com.sanwn.mousika

import com.sanwn.mousika.domain.Content
import com.sanwn.mousika.domain.Course
import com.sanwn.mousika.domain.CourseSection
import com.sanwn.mousika.domain.Page
import com.sanwn.mousika.services.CourseService
import grails.buildtestdata.mixin.Build
import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(CourseService)
@Build([Course, CourseSection,Content,Page])
class CourseServiceSpec extends Specification {

    def "move seciton to another position"() {
        given:
        def course = Course.build().save(flush: true)
        if (course.hasErrors()) {
            throw new RuntimeException("Error initializing")
        }
        def section = CourseSection.build(course: course).save(failOnError: true, flush: true)
        if (section.hasErrors()) {
            throw new RuntimeException("Error initializing")
        }
        2.times {
            section.addToContents(Page.build(sequence: it)).save(failOnError: true, flush: true)
            if (section.hasErrors()) {
                throw new RuntimeException("Error initializing")
            }
        }
        def targetSection = CourseSection.build(sequence: 1, course: course).save(failOnError: true, flush: true)
        3.times {
            targetSection.addToContents(Page.build(sequence: it)).save(failOnError: true, flush: true)
        }
        def lastSection = CourseSection.build(sequence: 2, course: course).save(failOnError: true, flush: true)
        4.times {
            lastSection.addToContents(Page.build(sequence: it)).save(failOnError: true, flush: true)
        }
        def oldSeq = section.sequence
        def newSeq = targetSection.sequence

        when:
        service.moveSection(section, targetSection)

        then:
        section.sequence == newSeq
        section.contents.size() == 2
        targetSection.sequence == oldSeq
        targetSection.contents.size() == 3
        lastSection.sequence == 2

    }
}
