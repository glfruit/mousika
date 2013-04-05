package com.sanwn.mousika.domain

class User {

    static searchable = true

    String username
    String passwordHash

    String fullname
    String email

    Date lastAccessed

    static hasMany = [roles: Role, permissions: String]

    static constraints = {
        username(nullable: false, blank: false, unique: true)
        lastAccessed nullable: true
    }

    static mapping = {
        table 'mousika_user'
    }
}
