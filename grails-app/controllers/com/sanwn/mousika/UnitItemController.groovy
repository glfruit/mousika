package com.sanwn.mousika

/**
 *
 * @author glix
 * @version 1.0
 *
 */
class UnitItemController {

    def unitItemService

    def courseUnitService

    def gsonBuilder

    def delete(Long id) {
        def courseId = params.courseId
        def unitSequence = params.unitSequence
        try {
            unitItemService.removeItem(courseId, unitSequence, id)
            render contentType: "application/json", text: '{"success":true}'
        } catch (UnitItemException e) {
            log.error("删除课程单元内容失败：${e.message}")
            render contentType: "application/json", text: '{"success":false}'
        } catch (Exception ex) {
            log.error("未知错误：${ex}")
            render contentType: "application/json", text: '{"success":false,"error":"未知错误"}'
        }
    }

    def copy(Long sourceId, Long targetId, String type) {
        def appendTo;
        def sourceItem = UnitItem.where {
            id == sourceId
        }.find()
        if (!sourceItem) {
            render contentType: 'application/json', text: '{"success":false,"error":"未找到源课程单元"}'
            return
        }
        def copy = sourceItem.copy()
        def targetUnit
        if ('unit' == type) {
            targetUnit = CourseUnit.where {
                id == targetId
            }.find()
            if (!targetUnit) {
                render contentType: 'application/json', text: '{"success":false,"error":"未找到对应的课程单元"}'
                return
            }
            appendTo = targetUnit.items.size()
        } else if ('unitItem' == type) {
            def targetItem = UnitItem.where {
                id == targetId
            }.find()
            if (!targetItem) {
                render contentType: 'application/json', text: '{"success":false,"error":"未找到对应的目标课程单元"}'
                return
            }
            appendTo = targetItem.sequence + 1
            targetUnit = targetItem.unit
        }
        try {
            courseUnitService.addUnitItem(targetUnit, copy, appendTo)
        } catch (CourseUnitException e) {
            render contentType: 'application/json', text: '{"success":false,"error":"导入课程单元失败"}'
            return
        }
        def result = gsonBuilder.create().toJson([
                success: true,
                id: copy.id,
                title: sourceItem.title,
                type: "unitItem"
        ])
        render contentType: 'application/json', text: result
    }
}
