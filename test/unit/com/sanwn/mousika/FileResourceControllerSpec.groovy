package com.sanwn.mousika

import grails.buildtestdata.mixin.Build
import grails.test.mixin.TestFor
import org.codehaus.groovy.grails.plugins.testing.GrailsMockMultipartFile
import spock.lang.Specification

@TestFor(FileResourceController)
@Build([Course, CourseUnit, Content, FileResource])
class FileResourceControllerSpec extends Specification {

    def "upload a valid file"() {
        given:
        def course = Course.build()
        def unit = CourseUnit.build()
        course.addToUnits(unit)
        course.save(failOnError: true)

        params.courseId = course.id
        params.sectionSeq = unit.sequence
        final file = new GrailsMockMultipartFile("qqfile", "qqfile".bytes)
        request.addFile(file)

        when:
        controller.upload()

        then:
        response.text == '{"success":true}'
        file.targetFileLocation.path != null

    }
}
