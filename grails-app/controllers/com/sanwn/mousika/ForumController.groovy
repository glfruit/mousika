package com.sanwn.mousika

class ForumController {

    def show(Long id) {
        def course = Course.get(params.courseId)
        def forum = Forum.where {
            course == course && id == id
        }.find()
        if (forum == null) {
            throw new RuntimeException("TO be processed")//TODO:统一指向一个出错页面
        }
        def total = Post.countByForum(forum)
        [forum: forum,total:total]
    }
}
