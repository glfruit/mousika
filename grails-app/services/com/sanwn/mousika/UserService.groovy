package com.sanwn.mousika

import org.apache.shiro.SecurityUtils

class UserException extends RuntimeException {

    String message

    User user
}

class UserService {

    def User getCurrentUser() {
        def username = SecurityUtils.getSubject().principal
        def user = User.where {
            username == username
        }.find()
        return user
    }

    def createOrUpdateProfileOf(User u) {
        def profile = u.profile
        Date d = new Date()
        if (profile == null) {
            profile = new Profile(user: u, firstAccessed: d, lastAccessed: d).save()
            if (!profile) {
                throw new UserException(message: "创建用户信息错误", user: user)
            }
            u.profile = profile
        } else {
            profile.lastAccessed = d
        }
    }
}
