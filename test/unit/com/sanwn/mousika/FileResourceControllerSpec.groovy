package com.sanwn.mousika

import com.sanwn.mousika.domain.Content
import com.sanwn.mousika.domain.Course
import com.sanwn.mousika.domain.CourseSection
import grails.buildtestdata.mixin.Build
import grails.test.mixin.TestFor
import org.codehaus.groovy.grails.plugins.testing.GrailsMockMultipartFile
import spock.lang.Specification

@TestFor(FileResourceController)
@Build([Course, CourseSection, Content, FileResource])
class FileResourceControllerSpec extends Specification {

    def "upload a valid file"() {
        given:
        def course = Course.build()
        def section = CourseSection.build()
        course.addToSections(section)
        course.save(failOnError: true)

        params.courseId = course.id
        params.sectionSeq = section.sequence
        final file = new GrailsMockMultipartFile("qqfile", "qqfile".bytes)
        request.addFile(file)

        when:
        controller.upload()

        then:
        response.text == '{"success":true}'
        file.targetFileLocation.path != null

    }
}
