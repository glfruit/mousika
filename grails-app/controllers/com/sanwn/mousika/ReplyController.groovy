package com.sanwn.mousika

import org.apache.commons.io.FileUtils
import org.apache.shiro.SecurityUtils

/**
 *
 * @author glix
 * @version 1.0
 *
 */
class ReplyController {

    def create() {
        def post = Post.get(params.id)
        [reply: new Reply(params), post: post]
    }

    def save() {
        def post = Post.get(params.postId)
        def reply = new Reply(params);
        def user = User.where {
            username == SecurityUtils.subject.principal
        }.find()
        reply.repliedBy = user
        def newFile

        def quickReply = params.boolean('quickReply')
        if (!quickReply) {
            def attachmentFile = request.getFile('attachment')
            if (attachmentFile.size != 0) {
                reply.attachment = attachmentFile.originalFilename
                def course = post.forum.course
                def fileRepo = new File(".", "courseFiles/${course.courseToken}/forum/${post.id}/")
                if (!fileRepo.exists()) {
                    FileUtils.forceMkdir(fileRepo)
                }
                newFile = new File(fileRepo, attachmentFile.originalFilename)
                attachmentFile.transferTo(newFile)
            }
        }

        post.addToReplies(reply)
        if (reply.validate() && post.save(flush: true)) {
            redirect(mapping: 'post', params: [courseId: post.forum.course.id, forumId: post.forum.id, id: post.id])
        } else {
            flash.message = "回复主题失败"
            if (newFile)
                newFile.delete()
            render(view: 'create', model: [reply: reply, post: post])
        }
    }

    def download(String id) {
        def course = Course.where {
            id == params.courseId
        }.find()
        def file = new File(".", "courseFiles/${course.courseToken}/forum/${params.postId}/${id}")
        response.setContentType("application/octet-stream")
        response.setContentLength(file.size().toInteger())
        def filename = new String(id.getBytes("UTF-8"), "ISO-8859-1")
        response.setHeader("Content-disposition", "attachment;filename=${filename}")
        response.outputStream << file.newInputStream()
        response.outputStream.flush()
    }
}
