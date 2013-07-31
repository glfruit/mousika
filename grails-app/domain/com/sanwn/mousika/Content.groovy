package com.sanwn.mousika

class Content {

    String title

    String description

    def type = this.class.simpleName[0].toLowerCase() + this.class.simpleName.substring(1)

    static transients = ['type']

    static constraints = {
        description nullable: true, blank: true
    }

    static mapping = {
        description column: "description", sqlType: "text"
    }
}
