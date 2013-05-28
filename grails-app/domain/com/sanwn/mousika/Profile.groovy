package com.sanwn.mousika

import com.sanwn.mousika.domain.User

class Profile {

    User user

    byte[] photo

    String email

    String interests

    Date firstAccessed

    Date lastAccessed

    static constraints = {
        photo nullable: true
        email email: true, nullable: true
        interests nullable: true
    }

    static mapping = {
        interests sqlType: 'text'
    }
}
