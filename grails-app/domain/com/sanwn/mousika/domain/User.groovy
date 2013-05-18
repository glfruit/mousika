package com.sanwn.mousika.domain

class User {

    static searchable = true

    String username
    String passwordHash

    String fullname
    String email

    Date dateCreated
    Date lastAccessed

    static hasMany = [roles: Role, permissions: String]

    static constraints = {
        username blank: false, unique: true, size: 6..20
        fullname blank: false
        lastAccessed nullable: true
    }

    static mapping = {
        table 'mousika_user'
    }
}
