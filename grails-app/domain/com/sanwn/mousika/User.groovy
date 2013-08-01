package com.sanwn.mousika

class User implements Comparable {

    static searchable = {
        roles reference:true
    }

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

    int compareTo(obj) {
        username.compareTo(obj.username)
    }
}
