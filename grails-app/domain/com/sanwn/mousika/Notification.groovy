package com.sanwn.mousika

/**
 *
 * @author glix
 * @version 1.0
 *
 */
class Notification {

    String title

    String content

    Date dateCreated

    static belongsTo = [course: Course]

    static constraints = {
        course nullable: true
    }

    static mapping = {
        table "mousika_notifications"
        content sqlType: 'text'
    }
}
