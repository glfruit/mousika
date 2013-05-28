package com.sanwn.mousika

import com.sanwn.mousika.domain.Page
import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Page)
class PageSpec extends Specification {

    def setup() {
        mockForConstraintsTests(Page, [new Page()])
    }

    def cleanup() {
    }

//    void "test something"() {
//        given:
//        def page = new Page("$field", val)
//
//        then:
//
//        where:
//
//    }

    void validateConstraints(obj, field, error) {
        def validated = obj.validate()
        if (error && error != 'valid') {
            assert !validated
            assert obj.errors[field]
            assert error == obj.errors[field]
        } else {
            assert !obj.errors[field]
        }
    }
}