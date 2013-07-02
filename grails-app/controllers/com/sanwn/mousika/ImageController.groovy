package com.sanwn.mousika

import com.sanwn.mousika.User

class ImageController {

    def renderImage() {
        def user = User.findById(params.id)
        if (user?.profile?.photo) {
            response.setContentLength(user.profile.photo.length)
            response.outputStream << user.profile.photo
        } else {
            response.sendError(404)
        }
    }
}
