package com.sanwn.mousika.domain

class Content implements Comparable {

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

    @Override
    int compareTo(Object o) {
        return sequence - o.sequence
    }
}
