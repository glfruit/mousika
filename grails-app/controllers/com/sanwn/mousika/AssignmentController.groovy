package com.sanwn.mousika

import com.sanwn.mousika.Course

class AssignmentCommand {

}

class AssignmentController {

    def assignmentService

    def create() {
        [assignment: new Assignment(params), sectionSeq: params.sectionSeq, courseId: params.courseId]
    }

    def save() {
        def enableAvailableFrom = params.boolean('enableAvailableFrom')
        def enableDueDate = params.boolean('enableDueDate')
        if (enableAvailableFrom) {
            params.availableFrom = params.date('availableFrom')
        } else {
            params.remove('availableFrom')
        }
        if (enableDueDate) {
            params.dueDate = params.date('dueDate')
        } else {
            params.remove('dueDate')
        }

        def assignment = new Assignment(params)
        def courseId = params.long('courseId')
        def sectionSeq = params.int('sectionSeq')
        try {
            assignmentService.createAssignment(courseId, sectionSeq, assignment)
        } catch (AssignmentException ae) {
            flash.message = ae.message
            render(view: 'create', model: [assignment: assignment, courseId:courseId,sectionSeq: sectionSeq])
            return
        } catch (Exception e) {
            log.error("未知的异常", e)
            flash.message = '系统内部错误'
            render(view: 'create', model: [assignment: assignment])
            return
        }
        def returnToCourse = params.boolean('returnToCourse')
        if (returnToCourse) {
            def course = Course.where {
                id == courseId
            }.find()
            redirect(controller: 'course', action: 'show', id: course.id)
        } else {
            redirect(action: 'show', id: assignment.id)
        }
    }
}
