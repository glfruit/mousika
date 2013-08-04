package com.sanwn.mousika

class Attempt {

    String attemptContent

    Feedback feedback

    User submittedBy

    Date submittedDate

    Date evaluateDate

    Double score

    static hasOne = [feedback: Feedback]

    static belongsTo = [assignment: Assignment]

    static constraints = {
        feedback nullable: true, blank: false
        evaluateDate nullable: true
    }

    def addFeedback(Feedback feedback) {
        feedback.attempt = this
        this.feedback = feedback
        this
    }
}
