package com.sanwn.mousika

class ResourceController {

    def userService

    def save() {
        def resource = new Resource(params)
        def user = userService.getCurrentUser()
        resource.createdBy = user
        resource.items = [:]
        resource.items['content'] = params.content
        if (!resource.save()) {
            flash.message = '创建资源失败'
            render(view: 'create', model: [resource: resource])
            return
        }
        redirect(action: 'show', id: resource.id)
    }
}
