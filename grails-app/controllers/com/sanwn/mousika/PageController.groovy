package com.sanwn.mousika

import org.springframework.dao.DataIntegrityViolationException

class PageController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def pageService

    def courseUnitService

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [pageInstanceList: Page.list(params), pageInstanceTotal: Page.count()]
    }

    def create() {
        def course = Course.get(params.courseId)
        [pageInstance: new Page(params), sectionSeq: params.sectionSeq, courseId: params.courseId, course: course]
    }

    def save() {
        def page = new Page(params)
        def courseId = params.long('courseId')
        def sectionSeq = params.int('sectionSeq')
        try {
            courseUnitService.createUnitItem(courseId, sectionSeq, page)
            def returnToCourse = params.boolean('returnToCourse')
            if (returnToCourse) {
                redirect(controller: 'course', action: 'show', id: params.courseId)
            } else {
                redirect(action: "show", id: page.id)
            }
        } catch (PageException pe) {
            flash.message = pe.message
            render(view: "create", model: [pageInstance: page, courseId: courseId, sectionSeq: sectionSeq])
            return
        } catch (Exception e) {
            flash.message = "内部错误"
            log.error("未知异常:", e)
            render(view: "create", model: [pageInstance: page, courseId: courseId, sectionSeq: sectionSeq])
        }
    }

    def show(Long id) {
        def pageInstance = Page.get(id)
        if (!pageInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'page.label', default: 'Page'), id])
            redirect(action: "list")
            return
        }

        [pageInstance: pageInstance]
    }

    def edit(Long id) {
        def pageInstance = Page.get(id)
        if (!pageInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'page.label', default: 'Page'), id])
            redirect(controller: 'course', action: "show", id: params.courseId)
            return
        }

        [pageInstance: pageInstance, course: Course.get(params.courseId)]
    }

    def update(Long id, Long version) {
        def pageInstance = Page.get(id)
        if (!pageInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'page.label', default: 'Page'), id])
            redirect(controller: 'course', action: "show", id: params.courseId)
            return
        }

        def course = Course.get(params.courseId)
        if (version != null) {
            if (pageInstance.version > version) {
                pageInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'page.label', default: 'Page')] as Object[],
                        "Another user has updated this Page while you were editing")
                render(view: "edit", model: [pageInstance: pageInstance, course: course])
                return
            }
        }

        pageInstance.properties = params

        if (!pageInstance.save(flush: true)) {
            render(view: "edit", model: [pageInstance: pageInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'page.label', default: 'Page'), pageInstance.id])
        redirect(action: "show", id: pageInstance.id)
    }

    def delete(Long id) {
        def pageInstance = Page.get(id)
        if (!pageInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'page.label', default: 'Page'), id])
            redirect(action: "list")
            return
        }

        try {
            pageInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'page.label', default: 'Page'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'page.label', default: 'Page'), id])
            redirect(action: "show", id: id)
        }
    }
}
