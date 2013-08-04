package com.sanwn.mousika

import org.springframework.dao.DataIntegrityViolationException

class UrlResourceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def courseUnitService

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [urlResourceInstanceList: UrlResource.list(params), urlResourceInstanceTotal: UrlResource.count()]
    }

    def create() {
        [urlResource: new UrlResource(params), courseId: params.courseId, sectionSeq: params.sectionSeq]
    }

    def save() {
        def urlResource = new UrlResource(params)
        def courseId = params.long('courseId')
        def sectionSeq = params.int('sectionSeq')
        try {
            courseUnitService.createUnitItem(courseId, sectionSeq, urlResource)
            redirect(controller: 'course', action: 'show', id: courseId)
        } catch (Exception e) {
            flash.message = "内部错误"
            log.error("未知异常:", e)
            render(view: "create", model: [urlResource: urlResource, courseId: courseId, sectionSeq: sectionSeq])
        }
    }

    def show(Long id) {
        def urlResourceInstance = UrlResource.get(id)
        if (!urlResourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'urlResource.label', default: 'UrlResource'), id])
            redirect(action: "list")
            return
        }

        [urlResourceInstance: urlResourceInstance]
    }

    def edit(Long id) {
        def urlResourceInstance = UrlResource.get(id)
        if (!urlResourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'urlResource.label', default: 'UrlResource'), id])
            redirect(action: "list")
            return
        }

        [urlResourceInstance: urlResourceInstance]
    }

    def update(Long id, Long version) {
        def urlResourceInstance = UrlResource.get(id)
        if (!urlResourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'urlResource.label', default: 'UrlResource'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (urlResourceInstance.version > version) {
                urlResourceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'urlResource.label', default: 'UrlResource')] as Object[],
                        "Another user has updated this UrlResource while you were editing")
                render(view: "edit", model: [urlResourceInstance: urlResourceInstance])
                return
            }
        }

        urlResourceInstance.properties = params

        if (!urlResourceInstance.save(flush: true)) {
            render(view: "edit", model: [urlResourceInstance: urlResourceInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'urlResource.label', default: 'UrlResource'), urlResourceInstance.id])
        redirect(action: "show", id: urlResourceInstance.id)
    }

    def delete(Long id) {
        def urlResourceInstance = UrlResource.get(id)
        if (!urlResourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'urlResource.label', default: 'UrlResource'), id])
            redirect(action: "list")
            return
        }

        try {
            urlResourceInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'urlResource.label', default: 'UrlResource'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'urlResource.label', default: 'UrlResource'), id])
            redirect(action: "show", id: id)
        }
    }
}
