package com.sanwn.mousika

import org.springframework.dao.DataIntegrityViolationException

class FileRepositoryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [fileRepositoryInstanceList: FileRepository.list(params), fileRepositoryInstanceTotal: FileRepository.count()]
    }

    def create() {
        [fileRepositoryInstance: new FileRepository(params)]
    }

    def save() {
        def fileRepositoryInstance = new FileRepository(params)
        if (!fileRepositoryInstance.save(flush: true)) {
            render(view: "create", model: [fileRepositoryInstance: fileRepositoryInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'fileRepository.label', default: 'FileRepository'), fileRepositoryInstance.id])
        redirect(action: "show", id: fileRepositoryInstance.id)
    }

    def show(Long id) {
        def fileRepositoryInstance = FileRepository.get(id)
        if (!fileRepositoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fileRepository.label', default: 'FileRepository'), id])
            redirect(action: "list")
            return
        }

        [fileRepositoryInstance: fileRepositoryInstance]
    }

    def edit(Long id) {
        def fileRepositoryInstance = FileRepository.get(id)
        if (!fileRepositoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fileRepository.label', default: 'FileRepository'), id])
            redirect(action: "list")
            return
        }

        [fileRepositoryInstance: fileRepositoryInstance]
    }

    def update(Long id, Long version) {
        def fileRepositoryInstance = FileRepository.get(id)
        if (!fileRepositoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fileRepository.label', default: 'FileRepository'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (fileRepositoryInstance.version > version) {
                fileRepositoryInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'fileRepository.label', default: 'FileRepository')] as Object[],
                        "Another user has updated this FileRepository while you were editing")
                render(view: "edit", model: [fileRepositoryInstance: fileRepositoryInstance])
                return
            }
        }

        fileRepositoryInstance.properties = params

        if (!fileRepositoryInstance.save(flush: true)) {
            render(view: "edit", model: [fileRepositoryInstance: fileRepositoryInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'fileRepository.label', default: 'FileRepository'), fileRepositoryInstance.id])
        redirect(action: "show", id: fileRepositoryInstance.id)
    }

    def delete(Long id) {
        def fileRepositoryInstance = FileRepository.get(id)
        if (!fileRepositoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fileRepository.label', default: 'FileRepository'), id])
            redirect(action: "list")
            return
        }

        try {
            fileRepositoryInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'fileRepository.label', default: 'FileRepository'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'fileRepository.label', default: 'FileRepository'), id])
            redirect(action: "show", id: id)
        }
    }
}
