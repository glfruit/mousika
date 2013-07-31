package com.sanwn.mousika

/**
 * 代表一个页面资源
 */
class Page extends Content {

    String content

    static constraints = {
        content blank: false
    }

    static searchable = true

    static mapping = {
        content column: "labelContent", sqlType: "text"
    }
}
