package com.sanwn.mousika.domain

/**
 * 代表一个页面资源
 */
class Page extends Content {

    String description

    String content

    static constraints = {
        title blank: false, maxSize: 200
        content blank: false
    }

    static mapping = {
        description column: "description", sqlType: "text"
        content column: "content", sqlType: "text"
    }
}
