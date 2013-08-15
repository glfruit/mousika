class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?" {
            constraints {
                // apply constraints here
            }
        }

        "/course/$id" {
            controller: 'course'
            action: 'show'
            constraints {
                id(matches: /\d+/)
            }
        }
        "/course/$courseId/forum/$id" {
            controller: 'forum'
            action: 'show'
            constraints {
                courseId(matches: /\d+/)
                id(matches: /\d+/)
            }
        }
        "/course/$courseId/forum/$forumId/post/$action/$id?"(controller: 'post')

        name mousika: "/course/$courseId/unit/$unitId/$controller/$action?/$id?" {
            constraints {
                courseId(matches: /\d+/)
                unitId(matches: /\d+/)
            }
        }

        "/"(controller: "course", action: "list")
        "500"(view: '/error')

        name forum: "/course/$courseId/forum/$id" {
            controller = 'forum'
            action = 'show'
        }

        name post: "/course/$courseId/forum/$forumId/posts/$id" {
            controller = 'post'
            action = 'show'
        }

        name reply: "/course/$courseId/forum/$forumId/posts/$id/reply" {
            controller = 'reply'
            action = 'create'
        }

        name attachmentDownload: "/course/$courseId/forum/$forumId/post/$postId/attachment/$id" {
            controller = 'post'
            action = 'download'
        }

        name replyAttachmentDownload: "/course/$courseId/forum/$forumId/post/$postId/reply/$replyId/attachment/$id" {
            controller = 'reply'
            action = 'download'
        }
    }
}
