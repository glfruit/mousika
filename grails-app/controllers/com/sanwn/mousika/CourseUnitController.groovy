package com.sanwn.mousika

class CourseUnitController {

    def courseService

    def courseUnitService

    def index() {}

    def updateUnit(UpdateCourseUnitCommand cmd) {
        try {
            courseUnitService.moveUnitItem(cmd.courseId, cmd.sourceUnitSeq, cmd.targetUnitSeq, cmd.sourceUnitItemSeq, cmd.targetUnitItemSeq,cmd.before)
            render contentType: "application/json", text: '{"success":true}'
        } catch (Exception e) {
            log.error("发生异常：", e)
            render contentType: "application/json", text: """{"success":false,"error":"${e.message}"}"""
        }
    }

    def updateSeq() {
        if (params.moveSection) {
            def course = Course.get(params.long('courseId'))
            def sourceUnit = CourseUnit.where {
                course == course && sequence == params.long('oldSection')
            }.find()
            def targetUnit = CourseUnit.where {
                course == course && sequence == params.long('targetSection')
            }.find()
            courseService.switchUnits(sourceUnit, targetUnit)
        } else {
            def courseId = params.long('courseId')
            def course = Course.get(courseId)
            def sourceSeq = params.long('sourceSeq')
            def sourceUnit = CourseUnit.where {
                course == course && sequence == sourceSeq
            }.find()
            if (sourceUnit == null) {
                log.warn("未在课程序号为${courseId}的课程中找到序号为${sourceSeq}的课程单元")
                render contentType: "application/json", text: '{"success":false}'
                return
            }
            def oldPos = params.int('oldPos')
            def newPos = params.int('newPos')

            def internal = params.boolean('internal')
            if (internal) {
                courseUnitService.moveContent(courseId, sourceSeq, oldPos, newPos)
                render contentType: "application/json", text: '{"success": true}'
                return
            }
            sourceSeq = params.long('sourceSeq')
            def targetSeq = params.long('targetSeq')
            try {
                courseUnitService.moveContentBetweenSections(courseId, sourceSeq, targetSeq, oldPos, newPos)
            } catch (CourseUnitException e) {
                flash.message = e.message
                render contentType: "application/json", text: '{"success":false}'
                return
            } catch (Exception ex) {
                flash.message = "内部错误"
                log.error("未知的异常：", ex)
                render contentType: "applicaiton/json", text: '{"success":false}'
                return
            }
        }

        render contentType: "application/json", text: '{"success":true}'
    }
}

class UpdateCourseUnitCommand {
    Long courseId
    int sourceUnitSeq
    int targetUnitSeq
    int sourceUnitItemSeq
    int targetUnitItemSeq
    boolean before
}
