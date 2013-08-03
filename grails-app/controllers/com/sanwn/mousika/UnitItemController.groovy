package com.sanwn.mousika

/**
 *
 * @author glix
 * @version 1.0
 *
 */
class UnitItemController {

    def unitItemService

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
            log.error("未知错误：${e}")
            render contentType: "application/json", text: '{"success":false,"error":"未知错误"}'
        }
    }
}
