package com.sanwn.mousika.domain

class Role {
    String name

    static hasMany = [users: User, permissions: String]
    static belongsTo = User

    static constraints = {
        name(nullable: false, blank: false, unique: true)
    }

    @Override
    def String toString() {
        return name
    }
}
