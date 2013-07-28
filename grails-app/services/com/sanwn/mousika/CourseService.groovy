package com.sanwn.mousika
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
    }
}
class CourseException extends RuntimeException {

    String message

    Course course
}