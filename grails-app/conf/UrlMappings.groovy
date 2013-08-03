class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?" {
            constraints {
                // apply constraints here
            }
        }

        "/course/$courseId/forum/$id"(controller: 'forum', action: 'show')
        "/course/$courseId/forum/$forumId/post/$action/$id?"(controller: 'post')

        "/"(view: "/index")
        "500"(view: '/error')

        name forum: "/course/$courseId/forum/$id" {
            controller = 'forum'
            action = 'show'
        }

        name post: "/course/$courseId/forum/$forumId/post/show/$id" {
            controller = 'post'
            action = 'show'
        }
    }
}
