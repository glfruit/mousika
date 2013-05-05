package com.sanwn.mousika

import com.sanwn.mousika.grails.MousikaTagLib
import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.GroovyPageUnitTestMixin} for usage instructions
 */
@TestFor(MousikaTagLib)
class MousikaTagLibSpec extends Specification {

    def "output copyright info"() {
        setup:
        messageSource.addMessage("default.company.name", request.locale, "深圳三栖科技有限公司")
        when:
        def copy = applyTemplate('<mousika:copyright />')

        then:
        copy == "&copy; 深圳三栖科技有限公司 2013"
    }
}