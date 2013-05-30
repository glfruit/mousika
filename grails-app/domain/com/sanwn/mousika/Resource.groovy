package com.sanwn.mousika

import com.sanwn.mousika.hibernate.HstoreType

/**
 * 代表一种资源
 */
class Resource {

    /**
     * 资源名称
     */
    String title

    /**
     * 资源类型
     */
    String type

    /**
     * 资源描述
     */
    String description

    Map<String, String> items

    User createdBy

    Date dateCreated

    static constraints = {
        title blank: false
        description nullable: true, blank: false
    }

    static mapping = {
        table 'mousika_resources'
        items type: HstoreType
    }
}
