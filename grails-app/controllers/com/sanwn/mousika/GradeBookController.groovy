package com.sanwn.mousika

/**
 *
 * @author glix
 * @version 1.0
 *
 */
class GradeBookController {

    def attemptService

    def show(Long id) {
        def course = Course.get(id)
        def assignmentItem = UnitItem.where {
            unit.course == course && id == params.assignmentItemId
        }.find()
        [attempts: assignmentItem.content.attempts, course: course, assignmentItem: assignmentItem]
    }

    def evaluate(Long id) {
        def attemptId = params.attemptId
        [attempt: Attempt.get(attemptId), assignmentItemId: params.assignmentItemId]
    }

    def save() {
        def attempt = new Attempt(params)

        try {
            attempt = attemptService.evaluate(params.long('attemptId'), params.double('score'), params.suggestion)
        } catch (AttemptException e) {
            flash.message = "更新作业成绩失败"
            log.error("更新作业成绩失败：${e}")
            render(view: "evaluate", params: [attemptId: attempt.id], model: [attempt: attempt])
            return
        } catch (Exception ex) {
            log.error("未知错误：${ex}")
            flash.message = "系统内部错误"
            render(view: "evaluate", params: [attemptId: attempt.id], model: [attempt: attempt])
            return
        }
        redirect(action: 'show', id: params.courseId, params: [assignmentItemId: params.assignmentItemId])
    }
}
