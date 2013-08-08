package com.sanwn.mousika

class Comment {

    Date dateCreated

    Date lastUpdated

    String commentContent

    User commenter

    static belongsTo = [reply: Reply]

    static constraints = {
    }

    static mapping = {
        table name: 'mousika_comments'
        commentContent sqlType: 'text'
    }
}
