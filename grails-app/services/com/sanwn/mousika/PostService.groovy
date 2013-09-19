package com.sanwn.mousika

import org.apache.shiro.SecurityUtils

class PostService {

    def createPost(Long forumId, Post post, fileRepo, attachmentFile) {
        def user = User.where {
            username == SecurityUtils.subject.principal
        }.find()
        post.postedBy = user
        post.lastModified = new Date()
        post.statistics = new PostStatistics(dateViewed: new Date(), post: post, total: 1)
        def forum = Forum.where {
            id == forumId
        }.find()
        forum.addToPosts(post)
        if (post.validate() && forum.save(flush: true)) {
            if (attachmentFile.size != 0) {
                post.attachment = attachmentFile.originalFilename
                def newFile = new File(fileRepo, attachmentFile.originalFilename)
                attachmentFile.transferTo(newFile)
            }
            return post
        }
        throw new PostException(message: "创建论坛帖子失败", post: post)
    }
}

class PostException extends RuntimeException {

    String message

    Post post
}
