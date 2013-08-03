package com.sanwn.mousika

class Reply {

    String title

    String replyContent

    Date dateCreated

    Date lastUpdated

    static belongsTo = [post: Post]

    static hasMany = [comments: Comment]

    static constraints = {
        title nullable: true, blank: true
    }

    static mapping = {
        table name: 'mousika_replies'
        replyContent sqlType: 'text'
    }
}
