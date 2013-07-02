package com.sanwn.mousika

import grails.buildtestdata.mixin.Build
import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(ResourceService)
@Build(User)
class ResourceServiceSpec extends Specification {

    def "create a page resource"() {
        given:
        def title = 'page title'
        def description = 'page description'
        def type = 'page'
        service.userService = [
                getCurrentUser: { return User.build() }
        ] as UserService

        when:
        def resource = service.createResource(type, title, description, [content: 'Page content'])

        then:
        resource != null
        resource.type == 'page'
        resource.items != null
        resource.items.size() == 1
        resource.items.content == 'Page content'
    }
}
