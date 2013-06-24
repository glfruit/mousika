package com.sanwn.mousika

class Attempt {

    String attemptContent

    Feedback feedback

    User submittedBy

    static belongsTo = [assignment: Assignment]

    static constraints = {
        feedback nullable: true, blank: false
    }
}
