package com.sanwn.mousika

import org.apache.commons.io.FileUtils
import org.apache.commons.io.FilenameUtils

/**
 *
 * @author glix
 * @version 1.0
 *
 */
class FileManagerController {

    public static FILE_EXTENSION_IMAGES = [

    ]

    public static IMAGES = [
            'bmp': true,
            'jpg': true,
            'jpeg': true,
            'png': true,
            'gif': true
    ]

    private def getCourseFileRepo(course) {
        def path = request.servletContext.getRealPath(".")
        def fileRepo
        if (course)
            fileRepo = new File(path, "courseFiles/${course.courseToken}")
        else
            fileRepo = new File(path, "notifications")
        if (!fileRepo.exists()) {
            FileUtils.forceMkdir(fileRepo)
        }
        return fileRepo
    }

    private def getCourseMaterialRepo(Course course) {
        def path = request.servletContext.getRealPath(".")
        def fileRepo = new File(path, "courseMaterials/${course.courseToken}")
        if (!fileRepo.exists()) {
            FileUtils.forceMkdir(fileRepo)
        }
        return fileRepo
    }

    def index() {
        def course = Course.get(params.courseId)
        def fileRepo = getCourseFileRepo(course)
        log.debug("寻找课程${course?.courseToken}的文件存放位置${fileRepo.getCanonicalPath()}")
        def currentPath = params.currentPath ?: '.'
        currentPath = currentPath + '/' + (params.target ?: '')
        def targetDirectory = new File(fileRepo, currentPath)
        def files = targetDirectory.listFiles({ file ->
            !file.isHidden()
        } as FileFilter)
        [files: files, course: course, currentPath: currentPath, editor: params.editor]
    }

    def changePath() {
        def course = Course.get(params.courseId)
        def fileRepo = getCourseMaterialRepo(course)
        def currentPath = params.currentPath ?: '.'
        currentPath = currentPath + '/' + (params.target ?: '')
        def targetDirectory = new File(fileRepo, currentPath)
        def files = targetDirectory.listFiles({ file ->
            !file.isHidden()
        } as FileFilter)
        [files: files, course: course, currentPath: currentPath, editor: params.editor]
    }

    def newFolder() {
        def fileRepo = getCourseFileRepo(Course.get(params.courseId))
        def newFolderPath = FilenameUtils.normalizeNoEndSeparator(params.currentPath) + '/' + params.folder
        def newFolder = new File(fileRepo, newFolderPath)
        if (newFolder.exists()) {
            render contentType: 'application/json', text: '{"success":false,"error":"已存在同名文件夹"}'
            return
        }
        FileUtils.forceMkdir(new File(fileRepo, newFolderPath))
        render contentType: 'application/json', text: '{"success":true,"currentPath":"' + newFolderPath + '"}'
    }

    def upload() {
        def course = Course.get(params.courseId)
        if (!course) {
            render(status: 404, text: "未找到指定课程，ID为${params.courseId}")
            return
        }
        try {
            def fileRepo = getCourseFileRepo(course)
            def uploadedFile = request.getFile('file')
            def targetFilepath = FilenameUtils.normalizeNoEndSeparator(params.currentPath) + '/' + uploadedFile.originalFilename
            uploadedFile.transferTo(new File(fileRepo, targetFilepath))
            render(status: 200, text: "文件上传成功")
        } catch (Exception e) {
            log.error("文件上传错误：${e}")
            render(status: 503, text: '文件上传错误')
        }
    }

    def rename() {
        def course = Course.get(params.courseId)
        def fileRepo = getCourseFileRepo(course)
        def oldFilename = FilenameUtils.normalizeNoEndSeparator(params.currentPath) + '/' + params.title
        def oldFile = new File(fileRepo, oldFilename)
        def newFilename = FilenameUtils.normalizeNoEndSeparator(params.currentPath) + '/' + params.newTitle
        oldFile.renameTo(new File(fileRepo, newFilename))
        render contentType: 'application/json', text: '{"success":true, "currentPath":"' + params.currentPath + '"}'
    }

    def download() {
        def course = Course.get(params.courseId)
        def fileRepo = getCourseFileRepo(course)
        def filepath = FilenameUtils.normalizeNoEndSeparator(params.currentPath) + '/' + params.filename
        def file = new File(fileRepo, filepath)
        def fileType = file.name.substring(file.name.lastIndexOf('.') + 1)
        def contentType = FileResource.FILE_TYPES[fileType]
        contentType = contentType ?: 'application/octet-stream'
        response.setContentType(contentType)
        response.setContentLength(file.size().toInteger())
        response.setCharacterEncoding("UTF-8")
        def filename = new String(file.name.getBytes("UTF-8"), "ISO-8859-1")
        filename = URLEncoder.encode(filename, "UTF-8")
        response.setHeader("Content-disposition", "attachment;filename=${filename}")
        response.outputStream << file.newInputStream()
//        response.outputStream.flush()
    }

    def remove() {
        def course = Course.get(params.courseId)
        def fileRepo = getCourseFileRepo(course)
        def removeFilename = FilenameUtils.normalizeNoEndSeparator(params.currentPath) + '/' + params.filename
        def file = new File(fileRepo, removeFilename)
        FileUtils.forceDelete(file)
        render contentType: 'application/json', text: '{"success":true,"currentPath":"' + params.currentPath + '"}'
    }
}
