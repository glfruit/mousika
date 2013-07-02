package com.sanwn.mousika

import grails.buildtestdata.mixin.Build
import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(ResourceController)
@Build([User, Resource])
class ResourceControllerSpec extends Specification {

    def "create a page resource"() {
        given:
        params.type = 'page'
        params.title = 'page title'
        params.content = 'This is a page'

        def user = User.build(username: 'pageuser')
        controller.resourceService = [
                createResource: { type, title, description, params ->
                    return Resource.build(type: type, title: title, description: description,
                            items: [content: params.content], createdBy: user)
                }
        ] as ResourceService

        when:
        controller.save()

        then:
        response.redirectedUrl == '/resource/show/1'
        Resource.count() == 1
        def resource = Resource.list()[0]
        resource.type == 'page'
        resource.title == 'page title'
        resource.items['content'] == 'This is a page'
    }
}