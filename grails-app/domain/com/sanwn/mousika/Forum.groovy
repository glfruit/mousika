package com.sanwn.mousika

class Forum extends Content {

    static hasMany = [posts: Post]

    static belongsTo = [course: Course]

    static constraints = {
    }

    static mapping = {
        table name: "mousika_forums"
        posts sort: 'lastModified', order: 'desc'
    }
}
