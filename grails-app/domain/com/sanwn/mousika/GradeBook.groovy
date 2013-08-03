package com.sanwn.mousika

/**
 * 成绩表
 */
class GradeBook {

    static belongsTo = [course: Course]

    static constraints = {
    }
}
