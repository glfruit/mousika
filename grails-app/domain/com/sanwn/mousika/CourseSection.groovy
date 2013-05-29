package com.sanwn.mousika

/**
 * 代表一门课程的一个教学单元
 */
class CourseSection {

    int sequence

    String title

    static belongsTo = [course: Course]

    static hasMany = [contents: Content]

    static constraints = {
    }

    static mapping = {
        sort sequence: 'asc'
        contents sort: 'sequence'
    }
}
