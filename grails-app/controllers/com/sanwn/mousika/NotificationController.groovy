package com.sanwn.mousika

/**
 *
 * @author glix
 * @version 1.0
 *
 */
class NotificationController {

    def gsonBuilder

    def create() {
        def notification = new Notification(params)
        def course = Course.get(params.courseId)
        return [notification: notification, course: course]
    }

    def save() {
        def course = Course.get(params.courseId)
        def notification = new Notification(params)
        if (params.notificationType == 'course') {
            course.addToNotifications(notification)
            if (notification.validate() && course.save(flush: true)) {
                redirect(action: 'show', id: notification.id, params: [courseId: course.id])
                return
            } else {
                render(view: "create", model: [courseId: params.courseId])
                return
            }
        }
        if (notification.save(flush: true)) {
            redirect(controller: 'course', action: 'show', id: course.id)
        } else {
            render(view: "create", model: [courseId: params.courseId])
        }
    }

    def list() {
        def course = Course.get(params.courseId)
        def notifications
        if (!course) {
            params.max = params.max ?: 10
            params.offset = params.offset ?: 0
            params.sort = params.sort ?: 'dateCreated'
            params.order = params.order ?: 'desc'
            notifications = Notification.where {
                course == null
            }.list(params)
            withFormat {
                html {
                    return [notification: notifications]
                }
                json {
                    def results = notifications.collect {
                        [
                                id: it.id,
                                title: it.title
                        ]
                    }
                    render contentType: 'application/json', text: gsonBuilder.create().toJson(results)
                    return
                }
            }

        }
        params.max = params.max ?: 20
        params.offset = params.offset ?: 0
        params.sort = params.sort ?: 'dateCreated'
        params.order = params.order ?: 'desc'
        notifications = Notification.where {
            course == course
        }.list(params)
        def total = Notification.countByCourse(course)
        [course: course, notifications: notifications, total: total]
    }

    def show(Long id) {
        def notification = Notification.get(id)
        if (!notification) {
            redirect(action: 'list')
            return
        }
        [notification: notification, course: Course.get(params.courseId)]
    }
}
