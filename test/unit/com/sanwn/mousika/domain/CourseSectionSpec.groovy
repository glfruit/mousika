package com.sanwn.mousika.domain

import grails.buildtestdata.mixin.Build
import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import spock.lang.Specification


/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestMixin(GrailsUnitTestMixin)
@Build([Course, CourseSection, Content, Page])
class CourseSectionSpec extends Specification {

    def "list content by sequence"() {
        given:
        def course = Course.build()
        def section = CourseSection.build()
        def titles = ['Page One', 'Page Two', 'Page Three']
        def pageOne = Page.build(sequence: 0, title: titles[0])
        def pageTwo = Page.build(sequence: 2, title: titles[2])
        def pageThree = Page.build(sequence: 1, title: titles[1])
        section.addToContents(pageOne)
        section.addToContents(pageTwo)
        section.addToContents(pageThree)
        course.addToSections(section)
        course.save(failOnError: true)

        when:
        def contents = section.getContents()

        then:
        contents.size() == 3
        contents.eachWithIndex { content, pos ->
            content.sequence == pos
            content.title == titles[pos]
        }
    }
}