package com.sanwn.mousika

import com.sanwn.mousika.domain.Role
import com.sanwn.mousika.domain.User
import grails.plugin.spock.IntegrationSpec

class ProfileIntegrationSpec extends IntegrationSpec {

    def fixtureLoader

    def "create a new profile for user"() {
        given: "an existing user without profile"
        def fixture = fixtureLoader.load {
            build {
                role(Role,name:"arole")
            }
            noBuild {
                user(User,roles:[role],username:'udfdsdfsdf',passwordHash:'pwd',fullname:'fn',dateCreated:new Date())
            }
        }
        def user = fixture.user

        when: "create a new profile"
        def p = new Profile(firstAccessed: new Date(), lastAccessed: new Date())
        user.profile = p
        user.save(flush:true)

        then: "a new profile shoul be created"
        p.id != null
        p.user == user
    }
}