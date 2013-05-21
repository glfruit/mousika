package com.sanwn.mousika

import grails.plugin.spock.IntegrationSpec

class AssignmentIntegrationSpec extends IntegrationSpec {

    def fixtureLoader

    def "saving a valid assignment"() {
        given: "a brand new assignment"
        def fixture = fixtureLoader.load("CourseFixture")
        def assignment = new Assignment(title: 'My Assignment', description: 'an assignment', sequence: 897)

        when: "the assignment is saved"
        fixture.section.addToContents(assignment).save(failOnError: true, flush: true)

        then:
        fixture.section.errors.errorCount == 0
        fixture.section.contents.toArray()[0].title == "My Assignment"
        assignment.errors.errorCount == 0
        assignment.id != null
    }
}