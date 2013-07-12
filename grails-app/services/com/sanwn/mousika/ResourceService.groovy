package com.sanwn.mousika

class ResourceService {

    static transactional = true

    def userService

    def createResource(String type, String title, String description, Map params) {
        def user = userService.getCurrentUser()
        def resource = new Resource(title: title, description: description, type: type, createdBy: user, items: [:])
        params.each { k, v -> resource.items."$k" = v }
        return resource
    }
}
