package com.sanwn.mousika
/**
 *
 * @author glix
 * @version 1.0
 *
 */
class CourseUnitService {

    static transactional = true

    def moveContent(courseId, sectionSeq, oldPos, newPos) {
        def course = Course.get(courseId)
        if (course == null) {
            throw new CourseUnitException(message: "指定ID为${courseId}的课程不存在")
        }
        def section = CourseUnit.where {
            course == course && sequence == sectionSeq
        }.find()
        if (section == null) {
            throw new CourseUnitException(message: "单元序号为${sectionSeq}的课程单元不存在")
        }
        def content = Content.findBySectionAndSequence(section, oldPos)
        if (content == null) {
            throw new CourseUnitException(message: "序号为${oldPos}的内容不存在", courseSection: section)
        }
        def targetContent = Content.findBySectionAndSequence(section, newPos)
        if (targetContent == null) {
            throw new CourseUnitException(message: "序号为${newPos}的内容不存在", courseSection: section)
        }
        targetContent.sequence = -1
        content.sequence = newPos
        targetContent.sequence = oldPos
        if (!targetContent.save() || !content.save()) {
            throw new CourseUnitException(message: "更新内容序列时出错", courseSection: section)
        }
    }

    def moveContentBetweenSections(courseId, sourceSectionSeq, targetSectionSeq, oldPos, newPos) {
        def course = Course.get(courseId)
        if (course == null) {
            throw new CourseUnitException(message: "指定ID为${courseId}的课程不存在")
        }
        def sourceSection = CourseUnit.findByCourseAndSequence(course, sourceSectionSeq)
        if (sourceSection == null) {
            throw new CourseUnitException(message: "单元序号为${sourceSectionSeq}的课程单元不存在")
        }
        def movedContent = sourceSection.contents.find {
            it.sequence == oldPos
        }
        if (movedContent == null) {
            throw new CourseUnitException(message: "序号为${oldPos}的内容不存在", courseSection: sourceSection)
        }
        def sourceContents = sourceSection.contents.findAll {
            it.sequence > oldPos
        }
        sourceContents.each {
            it.sequence = it.sequence - 1
        }
        def targetSection = CourseUnit.findByCourseAndSequence(course, targetSectionSeq)
        if (targetSection == null) {
            throw new CourseUnitException(message: "单元序号为${targetSectionSeq}的课程单元不存在")
        }
        def targetContents = targetSection.contents.findAll {
            it.sequence >= newPos
        }
        targetContents.each {
            it.sequence = it.sequence + 1
        }
        movedContent.sequence = newPos
        sourceSection.removeFromContents(movedContent)
        targetSection.addToContents(movedContent)
    }
}
class CourseUnitException extends RuntimeException {
    String message
    CourseUnit courseSection
}
