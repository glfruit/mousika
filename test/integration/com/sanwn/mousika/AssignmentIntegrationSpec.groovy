package com.sanwn.mousika

import grails.plugin.spock.IntegrationSpec

class AssignmentIntegrationSpec extends IntegrationSpec {

    def fixtureLoader

    def "saving a valid assignment"() {
        given: "a brand new assignment"
        def fixture = fixtureLoader.load("CourseFixture")
        def assignment = new Assignment(title: 'My Assignment', description: 'an assignment')
        def itemSize = fixture.section.items.size()

        when: "the assignment is saved"
        assignment.save(failOnError: true, flush: true)
        fixture.section.createUnitItem(assignment).save(failOnError: true, flush: true)

        then:
        fixture.section.errors.errorCount == 0
        fixture.section.items.size() == itemSize + 1
        assignment.errors.errorCount == 0
        assignment.id != null
    }
}