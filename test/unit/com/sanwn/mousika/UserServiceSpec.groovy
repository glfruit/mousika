package com.sanwn.mousika

import com.sanwn.mousika.domain.User
import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(UserService)
@Mock(User)
class UserServiceSpec extends Specification {

    def "create and save a valid new user"() {
        given: "a new user info is provided"
        def user = new User()

        when: "a new user is created by the service"
        def newUser = service.createUser("username", "password")
    }
}
