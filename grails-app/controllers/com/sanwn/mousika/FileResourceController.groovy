package com.sanwn.mousika

import org.springframework.dao.DataIntegrityViolationException

class FileResourceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [fileResourceInstanceList: FileResource.list(params), fileResourceInstanceTotal: FileResource.count()]
    }

    def create() {
        [fileResourceInstance: new FileResource(params), sectionSeq: params.sectionSeq, courseId: params.courseId]
    }

    def upload() {
        def course = Course.get(params.courseId)
        def section = CourseSection.findByCourseAndSequence(course, params.sectionSeq)
        def uploadedFile = request.getFile('qqfile')
        def filename = uploadedFile.originalFilename
        def fileResource = new FileResource(title: filename, section: section)
//        section.addToContents(fileResource)
//        if (!section.save(flush: true)) {
//            log.error("文件信息保存错误：${fileResource.errors.toString()}")
//            render contentType: "text/plain", text: '{"success":false}}'
//            return
//        }
//        log.info("尝试上传文件[${filename}]")
        uploadedFile.transferTo(new File(filename))
        render contentType: "text/plain", text: '{"success":true}'
    }

    def save() {
        def fileResourceInstance = new FileResource(params)
        if (!fileResourceInstance.save(flush: true)) {
            render(view: "create", model: [fileResourceInstance: fileResourceInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'fileResource.label', default: 'FileResource'), fileResourceInstance.id])
        redirect(action: "show", id: fileResourceInstance.id)
    }

    def show(Long id) {
        def fileResourceInstance = FileResource.get(id)
        if (!fileResourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fileResource.label', default: 'FileResource'), id])
            redirect(action: "list")
            return
        }

        [fileResourceInstance: fileResourceInstance]
    }

    def edit(Long id) {
        def fileResourceInstance = FileResource.get(id)
        if (!fileResourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fileResource.label', default: 'FileResource'), id])
            redirect(action: "list")
            return
        }

        [fileResourceInstance: fileResourceInstance]
    }

    def update(Long id, Long version) {
        def fileResourceInstance = FileResource.get(id)
        if (!fileResourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fileResource.label', default: 'FileResource'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (fileResourceInstance.version > version) {
                fileResourceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'fileResource.label', default: 'FileResource')] as Object[],
                        "Another user has updated this FileResource while you were editing")
                render(view: "edit", model: [fileResourceInstance: fileResourceInstance])
                return
            }
        }

        fileResourceInstance.properties = params

        if (!fileResourceInstance.save(flush: true)) {
            render(view: "edit", model: [fileResourceInstance: fileResourceInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'fileResource.label', default: 'FileResource'), fileResourceInstance.id])
        redirect(action: "show", id: fileResourceInstance.id)
    }

    def delete(Long id) {
        def fileResourceInstance = FileResource.get(id)
        if (!fileResourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fileResource.label', default: 'FileResource'), id])
            redirect(action: "list")
            return
        }

        try {
            fileResourceInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'fileResource.label', default: 'FileResource'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'fileResource.label', default: 'FileResource'), id])
            redirect(action: "show", id: id)
        }
    }
}
