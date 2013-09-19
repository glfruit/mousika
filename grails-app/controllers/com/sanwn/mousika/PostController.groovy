package com.sanwn.mousika

import org.apache.commons.io.FileUtils

/**
 *
 * @author glix
 * @version 1.0
 *
 */
class PostController {

    def postService

    def create() {
        [post: new Post(params)]
    }

    private def getCourseForumRepo(String courseToken) {
        def path = request.servletContext.getRealPath(".")
        return new File(path, "forumFiles/${courseToken}")
    }

    def save() {
        def post = new Post(params)
        def newFile
        def course = Course.get(params.courseId)
        def fileRepo = checkFileRepo(course.courseToken)
        def attachmentFile = request.getFile('attachment')
        try {
            post = postService.createPost(params.forumId, post, fileRepo, attachmentFile)
            redirect(mapping: 'post', params: [courseId: params.courseId, forumId: params.forumId, id: post.id])
        } catch (PostException pe) {
            flash.message = "创建新帖子失败"
            render(view: 'create', model: [post: post], params: [id: params.forumId])
        } catch (Exception e) {
            flash.message = "系统错误-创建新帖子失败"
            log.error(e)
            render(view: 'create', model: [post: post], params: [id: params.forumId])
        }
    }

    private checkFileRepo(courseToken) {
        def fileRepo = getCourseForumRepo(courseToken)
        if (!fileRepo.exists()) {
            FileUtils.forceMkdir(fileRepo)
        }
        return fileRepo
    }

    def show(Long id) {
        params.max = params.max ?: 20
        params.offset = params.offset ?: 0
        params.sort = params.sort ?: 'dateCreated'
        def post = Post.get(id)
        def replies = Reply.where {
            post == post
        }.list(params)
        def total = Reply.countByPost(post)
        [post: Post.get(id), replies: replies, total: total]
    }

    def download(String id) {
        def course = Course.where {
            id == params.courseId
        }.find()
        def file = getCourseForumRepo(course.courseToken)
        response.setContentType("application/octet-stream")
        response.setContentLength(file.size().toInteger())
        def filename = new String(id.getBytes("UTF-8"), "ISO-8859-1")
        response.setHeader("Content-disposition", "attachment;filename=${filename}")
        response.outputStream << file.newInputStream()
        response.outputStream.flush()
    }
}
