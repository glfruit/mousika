package com.sanwn.mousika.domain

class CourseSectionService {

    static transactional = true

    def moveContent(courseId, sectionSeq, oldPos, newPos) {
        def course = Course.get(courseId)
        if (course == null) {
            throw new CourseSectionException(message: "指定ID为${courseId}的课程不存在")
        }
        def section = CourseSection.findByCourseAndSequence(course, sectionSeq)
        if (section == null) {
            throw new CourseSectionException(message: "单元序号为${sectionSeq}的课程单元不存在")
        }
        def content = Content.findBySectionAndSequence(section, oldPos)
        if (content == null) {
            throw new CourseSectionException(message: "序号为${oldPos}的内容不存在", courseSection: section)
        }
        def targetContent = Content.findBySectionAndSequence(section, newPos)
        if (targetContent == null) {
            if (targetContent == null) {
                throw new CourseSectionException(message: "序号为${newPos}的内容不存在", courseSection: section)
            }
        }
        targetContent.sequence = oldPos
        content.sequence = newPos
    }

    def moveContentBetweenSections(courseId, sourceSectionSeq, targetSectionSeq, oldPos, newPos) {
        def course = Course.get(courseId)
        if (course == null) {
            throw new CourseSectionException(message: "指定ID为${courseId}的课程不存在")
        }
        def sourceSection = CourseSection.findByCourseAndSequence(course, sourceSectionSeq)
        if (sourceSection == null) {
            throw new CourseSectionException(message: "单元序号为${sourceSectionSeq}的课程单元不存在")
        }
        def movedContent = Content.findBySectionAndSequence(sourceSection, oldPos)
        if (movedContent == null) {
            throw new CourseSectionException(message: "序号为${oldPos}的内容不存在", courseSection: sourceSection)
        }
        def sourceContents = Content.findAllBySectionAndSequenceGreaterThan(sourceSection, oldPos)
        sourceContents.each {
            it.sequence = it.sequence - 1
        }
        def targetSection = CourseSection.findByCourseAndSequence(course, targetSectionSeq)
        if (targetSection == null) {
            throw new CourseSectionException(message: "单元序号为${targetSectionSeq}的课程单元不存在")
        }
        def targetContents = Content.findAllBySectionAndSequenceNotLessThan(targetSection, newPos)
        targetContents.each {
            it.sequence = it.sequence + 1
        }
        movedContent.sequence = newPos
        sourceSection.removeFromContents(movedContent)
        targetSection.addToContents(movedContent)
    }
}

class CourseSectionException extends RuntimeException {
    String message
    CourseSection courseSection
}
