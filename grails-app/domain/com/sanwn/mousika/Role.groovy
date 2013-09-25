package com.sanwn.mousika

class Role {

    static searchable = true

    static final String TEACHER = "教师"

    static final String STUDENT = "学生"

    static final String ADMIN = "系统管理员"

    String name

    Context context

    static hasMany = [users: User, permissions: String]

    static belongsTo = User

    static constraints = {
        name(nullable: false, blank: false)
        context nullable: true
    }

    @Override
    def String toString() {
        return name
    }
}
