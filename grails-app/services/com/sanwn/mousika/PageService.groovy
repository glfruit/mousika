package com.sanwn.mousika

import com.sanwn.mousika.domain.Content
import com.sanwn.mousika.domain.CourseSection
import com.sanwn.mousika.domain.Page

class PageException extends RuntimeException {

    String message

    Page page
}

class PageService {

    static transactional = true

    def createPage(Long courseId, int sectionSeq, Page page) {
        def section = CourseSection.where {
            course.id == courseId && sequence == sectionSeq
        }.find()
        if (section == null) {
            throw new PageException(message: "未在id为${courseId}的课程中找到序号为${sectionSeq}的章节")
        }
        def pageSequence = Content.countBySection(section)
        page.sequence = pageSequence
        section.addToContents(page)
        if (page.validate() && section.save()) {
            return page
        }
        throw new PageException(message: "创建页面内容错误", page: page)
    }
}
