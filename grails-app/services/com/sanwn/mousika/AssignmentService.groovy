package com.sanwn.mousika

import com.sanwn.mousika.Content
import com.sanwn.mousika.CourseSection

class AssignmentException extends RuntimeException {

    String message

    Assignment assignment
}

class AssignmentService {

    static transactional = true

    def createAssignment(Long courseId, int sectionSeq, Assignment assignment) {
        CourseSection section = CourseSection.where {
            course.id == courseId && sequence == sectionSeq
        }.find()
        if (section == null) {
            throw new AssignmentException(message: "创建作业错误：未在id为${courseId}的课程中找到序列为${sectionSeq}的章节")
        }
        def sequence = Content.countBySection(section)
        assignment.sequence = sequence
        section.addToContents(assignment)
        if (!assignment.validate() || !section.save()) {
            throw new AssignmentException(message: "创建作业错误", assignment: assignment)
        }
        return assignment
    }
}
