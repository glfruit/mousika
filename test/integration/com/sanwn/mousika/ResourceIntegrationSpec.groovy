package com.sanwn.mousika

import grails.plugin.spock.IntegrationSpec

class ResourceIntegrationSpec extends IntegrationSpec {

    def fixtureLoader

    def "create a valid resource"() {
        given:
        def fixture = fixtureLoader.load("UserFixture")
        def resource = new Resource(title: 'a title', description: 'some description', createdBy: fixture.user, items: ['content': 'This is a page'])

        when:
        resource.save()

        then:
        resource.hasErrors() == false
        resource.id != null
        resource.items.size() == 1
        resource.items['content'] == 'This is a page'
    }
}