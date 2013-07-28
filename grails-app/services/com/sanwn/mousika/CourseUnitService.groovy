package com.sanwn.mousika
/**
 *
 * @author glix
 * @version 1.0
 *
 */
class CourseUnitService {

    static transactional = true

    def createUnitItem(Long courseId, int unitSequence, Content content) {
        if (!content.validate() || !content.save()) {
            throw new CourseUnitException(message: "创建单元内容失败:${content.errors}")
        }
        def unit = CourseUnit.where {
            course.id == courseId && sequence == unitSequence
        }.find()
        if (unit == null) {
            throw new CourseUnitException(message: "指定的课程单元不存在-课程id:${courseId};单元序号:${unitSequence}")
        }
        def itemSeq = unit.items.size()
        def unitItem = new UnitItem(sequence: itemSeq, title: content.title, content: content)
        unit.addToItems(unitItem)
        if (unitItem.validate() && unit.save()) {
            return unit
        }
        throw new CourseUnitException(message: "创建单元内容失败：${unitItem.hasErrors() ? unitItem.errors : unit.errors}")
    }

    def moveContent(courseId, sectionSeq, oldPos, newPos) {
        def course = Course.get(courseId)
        if (course == null) {
            throw new CourseUnitException(message: "指定ID为${courseId}的课程不存在")
        }
        def unit = CourseUnit.where {
            course == course && sequence == sectionSeq
        }.find()
        if (unit == null) {
            throw new CourseUnitException(message: "单元序号为${sectionSeq}的课程单元不存在")
        }
        def sourceUnitItem = UnitItem.where {
            unit == unit && sequence == oldPos
        }.find()
        if (sourceUnitItem == null) {
            throw new CourseUnitException(message: "序号为${oldPos}的内容不存在", courseUnit: unit)
        }
        def targetUnitItem = UnitItem.where {
            unit == unit && sequence == newPos
        }.find()
        if (targetUnitItem == null) {
            throw new CourseUnitException(message: "序号为${newPos}的内容不存在", courseUnit: unit)
        }
        targetUnitItem.sequence = -1
        sourceUnitItem.sequence = newPos
        targetUnitItem.sequence = oldPos
        if (!targetUnitItem.save() || !sourceUnitItem.save()) {
            throw new CourseUnitException(message: "更新内容序列时出错", courseUnit: unit)
        }
    }

    def moveContentBetweenSections(courseId, sourceSectionSeq, targetSectionSeq, oldPos, newPos) {
        def course = Course.get(courseId)
        if (course == null) {
            throw new CourseUnitException(message: "指定ID为${courseId}的课程不存在")
        }
        def sourceUnit = CourseUnit.where {
            course == course && sequence == sourceSectionSeq
        }.find()
        if (sourceUnit == null) {
            throw new CourseUnitException(message: "单元序号为${sourceSectionSeq}的课程单元不存在")
        }
        def movedContent = UnitItem.where {
            sequence == oldPos
        }.find()
        if (movedContent == null) {
            throw new CourseUnitException(message: "序号为${oldPos}的内容不存在", courseUnit: sourceUnit)
        }
        def sourceContents = UnitItem.where {
            sequence > oldPos
        }.list()
        sourceContents.each {
            it.sequence = it.sequence - 1
        }
        def targetUnit = CourseUnit.where {
            course == course && sequence == targetSectionSeq
        }.find()
        if (targetUnit == null) {
            throw new CourseUnitException(message: "单元序号为${targetSectionSeq}的课程单元不存在")
        }
        def targetContents = UnitItem.where {
            sequence >= newPos
        }.list()
        targetContents.each {
            it.sequence = it.sequence + 1
        }
        movedContent.sequence = newPos
        sourceUnit.removeFromItems(movedContent)
        targetUnit.addToItems(movedContent)
    }
}
class CourseUnitException extends RuntimeException {
    String message
    CourseUnit courseUnit
}
