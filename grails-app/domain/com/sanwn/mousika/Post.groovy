package com.sanwn.mousika

class Post {

    String title

    String postContent

    User postedBy

    Date dateCreated

    Date lastUpdated

    String attachment

    static hasMany = [replies: Reply]

    static belongsTo = [forum: Forum]

    static constraints = {
        attachment nullable: true, blank: true
    }

    static mapping = {
        table name: 'mousika_forum_posts'
        postContent sqlType: 'text'
    }
}
