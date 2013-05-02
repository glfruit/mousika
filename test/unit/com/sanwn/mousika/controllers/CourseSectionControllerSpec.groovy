package com.sanwn.mousika.controllers

import com.sanwn.mousika.domain.*
import grails.buildtestdata.mixin.Build
import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 *
 * @author glix
 * @version 1.0
 *
 */
@TestFor(CourseSectionController)
@Mock(CourseSectionService)
@Build([Course, CourseSection, Content, Page])
class CourseSectionControllerSpec extends Specification {

    def "update content sequence between two differnece sections"() {
        given:
        def course = new Course(code: 'code', title: "course", startDate: new Date()).save(failOnError: true)
        def section = new CourseSection(title: 'section1', sequence: 0, course: course).save(failOnError: true)
        3.times {
            def page = new Page(sequence: it, title: "page${it}", content: "Page Content", section: section).save(failOnError: true, flush: true)
            section.addToContents(page)
        }
        def targetSection = new CourseSection(title: 'section2', sequence: 1, course: course).save(failOnError: true)
        4.times {
            def page = new Page(sequence: it, title: "page${it}", content: "Page Content", section: targetSection).save(failOnError: true, flush: true)
            targetSection.addToContents(page)
        }

        params.internal = false
        params.courseId = course.id
        params.sourceSeq = section.sequence
        params.targetSeq = targetSection.sequence
        params.oldPos = 1
        params.newPos = 2

        when:
        controller.updateSeq()

        then:
        response.text == '{"success":true}'
    }
}
