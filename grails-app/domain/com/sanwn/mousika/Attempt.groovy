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

    static mapping = {
        table 'mousika_course_assignment_attempts'
        description column: "attempt_content", sqlType: "text"
    }

    def addFeedback(Feedback feedback) {
        feedback.attempt = this
        this.feedback = feedback
        this
    }

}
