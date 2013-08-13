package com.sanwn.mousika

class Feedback {

    String suggestion

    static mapping = {
        table 'mousika_feedbacks'
    }

    static belongsTo = [attempt: Attempt]

    static constraints = {
    }
}
