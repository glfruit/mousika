package com.sanwn.mousika

import com.sanwn.mousika.domain.CourseSection

class AssignmentController {

    def assignmentService

    def create() {
        [assignment: new Assignment(params), sectionSeq: params.sectionSeq, courseId: params.courseId]
    }

    def save() {
        params.availableFrom = params.date('availableFrom')
        params.dueDate = params.date('dueDate')
        def assignment = new Assignment(params)
        try {
            def courseId = params.courseId
            def sectionSeq = params.sectionSeq
            def section = CourseSection.where {
                course.id == courseId && sequence == sectionSeq
            }.find()
            section.addToContents(assignment)
            section.save(flush: true)
        } catch (AssignmentException e) {
            flash.message = e.message
            render(view: 'create', model: [assignment: assignment])
            return
        }
        def returnToCourse = params.boolean('returnToCourse')
        if (returnToCourse) {
            def courseId = params.courseId
            def sectionSeq = params.sectionSeq
            def section = CourseSection.where {
                course.id == courseId && sequence == sectionSeq
            }.find()
            section.addToContents(assignment)
            redirect(controller: 'course', action: 'show', id: section.course.id)
        } else {
            redirect(action: 'show', id: assignment.id)
        }
    }
}
