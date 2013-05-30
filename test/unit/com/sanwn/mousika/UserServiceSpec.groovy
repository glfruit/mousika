package com.sanwn.mousika

import grails.buildtestdata.mixin.Build
import grails.test.mixin.TestFor
import org.apache.shiro.SecurityUtils
import org.apache.shiro.subject.Subject
import org.apache.shiro.util.ThreadContext
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(UserService)
@Build(User)
class UserServiceSpec extends Specification {

    def "get current logged in user"() {
        given:
        def subject = [getPrincipal: { "auser" }, isAuthenticated: true] as Subject
        ThreadContext.put(ThreadContext.SECURITY_MANAGER_KEY, [getSubject: { subject }] as SecurityManager)
        SecurityUtils.metaClass.static.getSubject = { subject }
        def user = User.build(username: 'auser')

        when:
        user = service.getCurrentUser()

        then:
        user != null

    }

//    def "create and save a valid new user"() {
//        given: "a new user info is provided"
//        def user = new User()
//
//        when: "a new user is created by the service"
//        def newUser = service.createUser("username", "password")
//    }
}
