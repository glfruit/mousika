package com.sanwn.mousika

import org.apache.commons.io.FileUtils
import org.apache.commons.io.FilenameUtils
import org.apache.shiro.SecurityUtils
import org.springframework.dao.DataIntegrityViolationException

class FileRepositoryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        SecurityUtils.subject.session.setAttribute(FileRepository.REPOSITORY_TYPE, FileRepository.REPOSITORY_TYPE_FILE)
        SecurityUtils.subject.session.setAttribute(FileRepository.REPOSITORY_PATH, SecurityUtils.subject.principal)
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def courseId = params.courseId
        def course = Course.get(courseId)
        [fileRepositoryInstanceList: FileRepository.list(params), fileRepositoryInstanceTotal: FileRepository.count(), course: course]
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

    private def getUserRepo(User user) {
        def path = request.servletContext.getRealPath(".")
        def fileRepo = new File(path, "userFiles/${user.username}")
        if (!fileRepo.exists()) {
            FileUtils.forceMkdir(fileRepo)
        }
        return fileRepo
    }

    def show(String id) {
        def user = User.where {
            username == id
        }.find()
        def fileRepo = getUserRepo(user)
        def currentPath = params.currentPath ?: '.'
        currentPath = currentPath + '/' + (params.target ?: '')
        def targetDirectory = new File(fileRepo, currentPath)
        def files = targetDirectory.listFiles({ file ->
            !file.isHidden()
        } as FileFilter)
        [user: user, files: files, currentPath: currentPath]
    }

    def upload() {
        def user = User.where {
            username == params.username
        }.find()
        try {
            def fileRepo = getUserRepo(user)
            def uploadedFile = request.getFile('file')
            def targetFilepath = FilenameUtils.normalizeNoEndSeparator(params.currentPath) + '/' + uploadedFile.originalFilename
            uploadedFile.transferTo(new File(fileRepo, targetFilepath))
            render(status: 200, text: "文件上传成功")
        } catch (Exception e) {
            log.error("文件上传错误：${e}")
            render(status: 503, text: '文件上传错误')
        }
    }

    def newFolder() {
        def user = User.where {
            username == params.username
        }.find()
        def fileRepo = getUserRepo(user)
        def newFolderPath = FilenameUtils.normalizeNoEndSeparator(params.currentPath) + '/' + params.folder
        def newFolder = new File(fileRepo, newFolderPath)
        if (newFolder.exists()) {
            render contentType: 'application/json', text: '{"success":false,"error":"已存在同名文件夹"}'
            return
        }
        FileUtils.forceMkdir(new File(fileRepo, newFolderPath))
        render contentType: 'application/json', text: '{"success":true,"currentPath":"' + newFolderPath + '"}'
    }

    def download() {
        def user = User.where {
            username == params.username
        }.find()
        def fileRepo = getUserRepo(user)
        def filepath = FilenameUtils.normalizeNoEndSeparator(params.currentPath) + '/' + params.filename
        def file = new File(fileRepo, filepath)
        def fileType = file.name.substring(file.name.lastIndexOf('.') + 1)
        def contentType = FileResource.FILE_TYPES[fileType]
        contentType = contentType ?: 'application/octet-stream'
        response.setContentType(contentType)
        response.setContentLength(file.size().toInteger())
        response.setCharacterEncoding("UTF-8")
        def filename = new String(file.name.getBytes("UTF-8"), "ISO-8859-1")
//        filename = URLEncoder.encode(filename, "UTF-8")
        response.setHeader("Content-disposition", "attachment;filename=\"${filename}\";")
        response.outputStream << file.newInputStream()
    }


    def rename() {
        def user = User.where {
            username == params.username
        }.find()
        def fileRepo = getUserRepo(user)
        def oldFilename = FilenameUtils.normalizeNoEndSeparator(params.currentPath) + '/' + params.title
        def oldFile = new File(fileRepo, oldFilename)
        def newFilename = FilenameUtils.normalizeNoEndSeparator(params.currentPath) + '/' + params.newTitle
        oldFile.renameTo(new File(fileRepo, newFilename))
        render contentType: 'application/json', text: '{"success":true, "currentPath":"' + params.currentPath + '"}'
    }

    def remove() {
        def user = User.where {
            username == params.username
        }.find()
        def fileRepo = getUserRepo(user)
        def removeFilename = FilenameUtils.normalizeNoEndSeparator(params.currentPath) + '/' + params.filename
        def file = new File(fileRepo, removeFilename)
        FileUtils.forceDelete(file)
        render contentType: 'application/json', text: '{"success":true,"currentPath":"' + params.currentPath + '"}'
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
