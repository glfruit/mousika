package com.sanwn.mousika

import org.apache.commons.io.FileUtils
import org.springframework.dao.DataIntegrityViolationException

class FileResourceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def courseUnitService

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
        def courseId = params.courseId
        def sectionSeq = params.int('sectionSeq')
        def course = Course.get(params.courseId)
        def uploadedFile = request.getFile('qqfile')
        def filename = uploadedFile.originalFilename
        def fileRepo = new File(".", "courseFiles/${course.code}")
        if (!fileRepo.exists()) {
            FileUtils.forceMkdir(fileRepo)
        }
        def newFile = new File(fileRepo, filename)
        uploadedFile.transferTo(newFile)
        def fileResource = new FileResource(params)
        fileResource.filePath = newFile.getCanonicalPath()
        def pos = filename.lastIndexOf('.')
        if (pos == -1) {
            fileResource.fileType = '*' //unknown file type
        } else {
            fileResource.fileType = filename.substring(pos + 1)
        }
        try {
            courseUnitService.createUnitItem(course.id, sectionSeq, fileResource)
            redirect(controller: 'course', action: 'show', id: courseId)
//            render contentType: "text/plain", text: '{"success":true}'
        } catch (CourseUnitException e) {
            newFile.delete()
//            render contentType: "text/plain", text: '{"success":false}}'
            flash.message = e.message
            render(view: "create", model: [fileResourceInstance: fileResource, courseId: courseId, sectionSeq: sectionSeq])
            return
        } catch (Exception ex) {
            newFile.delete()
//            render contentType: "text/plain", text: '{"success":false}}'
//            return
            flash.message = "系统内部错误"
            log.error("未知异常：", ex)
            render(view: "create", model: [fileResourceInstance: fileResource, courseId: courseId, sectionSeq: sectionSeq])
        }
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
        def fileResource = FileResource.get(id)
        def file = new File(fileResource.filePath)
        def contentType = FileResource.FILE_TYPES[fileResource.fileType]
        contentType = contentType ? contentType : "application/octet-stream"
        def supportedPlay = "mp3,m4v,m4a,wav,flv"
        def range = request.getHeader('Range') //TODO: parse 0-n?
        if (supportedPlay.indexOf(fileResource.fileType) != -1) {
            response.reset()
            response.setStatus(206)
            response.addHeader("Accept-Ranges", "bytes")
            response.addHeader("Content-length", String.valueOf(file.length() + 1))
            response.addHeader("Content-range", "bytes 0-" + file.length() + "/" + (file.length() + 1))
        }
        response.setContentType(contentType)
        response.setContentLength(file.length().toInteger())
        response.setCharacterEncoding("UTF-8")
        def filename = "${fileResource.title}.${fileResource.fileType}"
        filename = new String(filename.getBytes("UTF-8"), "ISO-8859-1")
        response.setHeader("Content-disposition", "attachment;filename=${filename}")
        response.outputStream << file.newInputStream()
        response.outputStream.flush()
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
