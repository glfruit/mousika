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

    def moveSection(sourceSection, targetSection) {
        def oldSeq = sourceSection.sequence
        def newSeq = targetSection.sequence
        targetSection.sequence = oldSeq
        sourceSection.sequence = newSeq
    }
}
class CourseException extends RuntimeException {

    String message

    Course course
}