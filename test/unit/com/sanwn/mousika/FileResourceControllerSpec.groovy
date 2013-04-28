package com.sanwn.mousika

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import org.codehaus.groovy.grails.plugins.testing.GrailsMockMultipartFile
import spock.lang.Specification

@TestFor(FileResourceController)
@Mock(FileResource)
class FileResourceControllerSpec extends Specification {

    def "upload a valid file"() {
        given:
        final file = new GrailsMockMultipartFile("qqfile", "qqfile".bytes)
        request.addFile(file)

        when:
        controller.upload()

        then:
        response.text == '{"success":true}'
        file.targetFileLocation.path == "upload"

    }
}
