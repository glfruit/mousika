package com.sanwn.mousika.domain

import com.sanwn.mousika.Profile

class User {

    static searchable = true

    String username
    String passwordHash

    String fullname

    Date dateCreated

    static hasMany = [roles: Role, permissions: String]

    static hasOne = [profile: Profile]

    static constraints = {
        username blank: false, unique: true, size: 5..20
        fullname blank: false
        profile nullable: true
    }

    static mapping = {
        table 'mousika_user'
    }
}
