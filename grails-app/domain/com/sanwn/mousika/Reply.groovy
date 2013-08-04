package com.sanwn.mousika

class Reply {

    String replyContent

    User repliedBy

    String attachment

    Date dateCreated

    Date lastUpdated

    static belongsTo = [post: Post]

    static hasMany = [comments: Comment]

    static constraints = {
        attachment nullable: true
    }

    static mapping = {
        table name: 'mousika_replies'
        replyContent sqlType: 'text'
    }
}
