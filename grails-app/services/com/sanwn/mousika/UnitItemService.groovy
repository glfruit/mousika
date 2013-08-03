package com.sanwn.mousika

import org.springframework.dao.DataIntegrityViolationException

class UnitItemService {

    static transactional = true

    def removeItem(courseId, unitSequence, itemSequence) {
        def unit = CourseUnit.where {
            course.id == courseId && sequence == unitSequence
        }.find()
        if (!unit) {
            throw new UnitItemException(message: "未在id为${courseId}的课程中找到序号为${unitSequence}的单元")
        }
        def unitItem = UnitItem.where {
            unit == unit && sequence == itemSequence
        }.find()
        if (!unitItem) {
            throw new UnitItemException(message: "未在id为${courseId}的课程序号为${unitSequence}的单元中找到序号为${itemSequence}的内容")
        }
        try {
            unitItem.delete(flush: true)
        } catch (DataIntegrityViolationException e) {
            throw new UnitItemException(message: "删除单元内容失败", unitItem: unitItem)
        }
    }
}

class UnitItemException extends RuntimeException {

    String message

    UnitItem unitItem
}
