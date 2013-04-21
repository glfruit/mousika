package com.sanwn.mousika.domain

class Content {

    int sequence

    String title

    def type = this.class.simpleName.toLowerCase()

    static transients = ['type']

    static belongsTo = [section: CourseSection]

    static constraints = {
    }
}
