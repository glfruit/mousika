package com.sanwn.mousika

class Feedback {

    String suggestion

    static belongsTo = [attempt: Attempt]

    static constraints = {
    }
}
