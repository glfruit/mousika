package com.sanwn.mousika

class AssignmentCommand {

}

class AssignmentController {

    def assignmentService

    def userService

    def courseUnitService

    def create() {
        def course = Course.get(params.courseId)
        [assignment: new Assignment(params), sectionSeq: params.sectionSeq, courseId: params.courseId, course: course]
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
            courseUnitService.createUnitItem(courseId, sectionSeq, assignment)
        } catch (AssignmentException ae) {
            flash.message = ae.message
            render(view: 'create', model: [assignment: assignment, courseId: courseId, sectionSeq: sectionSeq])
            return
        } catch (Exception e) {
            log.error("未知的异常", e)
            flash.message = '系统内部错误'
            render(view: 'create', model: [assignment: assignment, courseId: courseId, sectionSeq: sectionSeq])
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

    def show(Long id) {
        def assignment = Assignment.get(id)
        if (!assignment) {
            flash.message = "未找到指定的作业"
            redirect(action: 'list')
            return
        }
        def u = userService.currentUser
        def attempt = Attempt.where {
            submittedBy == u && assignment == assignment
        }.find()

        [assignment: assignment, attempt: attempt, course: Course.get(params.courseId), unit: CourseUnit.get(params.unitId)]
    }

    def createAttempt() {
        def attempt = new Attempt(params)
        def u = userService.currentUser
        attempt.submittedBy = u
        def assignment = Assignment.get(params.assignmentId)
        assignment.addToAttempts(attempt)
        if (attempt.validate() && assignment.save()) {
            redirect(action: 'show', id: assignment.id)
            return
        }
        flash.message = "保存答案失败"
        render(view: 'show', model: [assignment: assignment, attempt: attempt])
    }

    def edit(Long id) {
        def assignment = Assignment.get(id)
        if (!assignment) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'assignment.label', default: 'Assignment'), id])
            redirect(controller: "course", action: "show", id: params.courseId)
            return
        }

        [assignment: assignment, course: Course.get(params.courseId), unit: CourseUnit.get(params.unitId)]
    }

    def update(Long id, Long version) {
        def assignment = Assignment.get(id)
        if (!assignment) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'assignment.label', default: 'Assignment'), id])
            redirect(controller: 'course', action: 'show', id: params.courseId)
            return
        }

        if (version != null) {
            if (assignment.version > version) {
                assignment.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'assignment.label', default: 'FileResource')] as Object[],
                        "Another user has updated this FileResource while you were editing")
                render(view: "edit", model: [fileResourceInstance: assignment, course: Course.get(params.courseId), unitId: params.unitId])
                return
            }
        }

        assignment.properties = params
        if (!assignment.save(flush: true)) {
            render(view: "edit", model: [assignment: assignment, course: Course.get(params.courseId), unitId: params.unitId])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'assignment.label', default: 'Assignment'), assignment.id])
        redirect(controller: 'course', action: "show", id: params.courseId)
    }
}
