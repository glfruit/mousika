package com.sanwn.mousika

import org.apache.commons.io.FileUtils
import org.apache.shiro.SecurityUtils

/**
 *
 * @author glix
 * @version 1.0
 *
 */
class PostController {

    def create() {
        [post: new Post(params)]
    }

    def save() {
        def post = new Post(params);
        def newFile
        def attachmentFile = request.getFile('attachment')
        if (attachmentFile.size != 0) {
            post.attachment = attachmentFile.originalFilename
            def course = Course.get(params.courseId)
            def fileRepo = new File(".", "courseFiles/${course.courseToken}/forum")
            if (!fileRepo.exists()) {
                FileUtils.forceMkdir(fileRepo)
            }
            newFile = new File(fileRepo, attachmentFile.originalFilename)
            attachmentFile.transferTo(newFile)
        }
        def user = User.where {
            username == SecurityUtils.subject.principal
        }.find()
        post.postedBy = user
        def forum = Forum.where {
            id == params.forumId
        }.find()
        forum.addToPosts(post)
        if (post.validate() && forum.save(flush: true)) {
            redirect(mapping: 'post', params: [courseId: params.courseId, forumId: params.forumId, id: post.id])
        } else {
            flash.message = "创建新帖子失败"
            if (newFile)
                newFile.delete()
            render(view: 'create', model: [post: post], params: [id: params.forumId])
        }
    }

    def show(Long id) {
        render "Post showed"
    }
}
