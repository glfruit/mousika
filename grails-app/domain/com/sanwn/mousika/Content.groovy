package com.sanwn.mousika

class Content {

    int sequence

    String title

    String description

    def type = this.class.simpleName.toLowerCase()

    static transients = ['type']

    static belongsTo = [section: CourseSection]

    static constraints = {
        description nullable: true, blank: true
    }

    static mapping = {
        description column: "description", sqlType: "text"
    }
}
