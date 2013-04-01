package com.sanwn.mousika.domain

class User {

    static searchable = true

    String username
    String passwordHash

    String fullname
    String email
    
    static hasMany = [ roles: Role, permissions: String ]

    static constraints = {
        username(nullable: false, blank: false, unique: true)
    }
}
