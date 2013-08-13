package com.sanwn.mousika

import org.springframework.dao.DataIntegrityViolationException

/**
 *
 * @author glix
 * @version 1.0
 *
 */
class CourseService {

    static transactional = true

    def createCourse() {
        def course = new Course()
        if (course.validate() && course.save()) {
            return course
        } else {
            throw new CourseException(message: "Error creating course ${course.title}")
        }
    }

    def switchUnits(sourceUnit, targetUnit) {
        def oldSeq = sourceUnit.sequence
        def newSeq = targetUnit.sequence
        targetUnit.sequence = oldSeq
        sourceUnit.sequence = newSeq
        sourceUnit.reindex()
        targetUnit.reindex()
    }

    def removeUnit(CourseUnit courseUnit) {
        def course = courseUnit.course
        try {
            course.numberOfWeeks = course.numberOfWeeks - 1
            course.units.each { unit ->
                if (unit.sequence > courseUnit.sequence) {
                    unit.sequence = unit.sequence - 1
                }
            }
            course.removeFromUnits(courseUnit)
            courseUnit.delete(flush: true)
            course.save(flush: true)
            courseUnit.reindex()
        } catch (DataIntegrityViolationException e) {
            throw new CourseException(message: "删除课程单元${courseUnit.title}失败", course: course)
        }
    }
}
class CourseException extends RuntimeException {

    String message

    Course course
}