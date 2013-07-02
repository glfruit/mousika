package com.sanwn.mousika

class ResourceController {

    def resourceService

    def create() {
        [resource: new Resource(params), type: params.type, courseId: params.courseId, sectionSeq: params.sectionSeq]
    }

    def save() {
        def resource = resourceService.createResource(params.type, params.title, params.description, [content: params.content])
        if (!resource.save()) {
            flash.message = '创建资源失败'
            render(view: 'create', model: [resource: resource]  )
            return
        }
        redirect(action: 'show', id: resource.id)
    }
}
