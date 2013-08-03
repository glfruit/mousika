package com.sanwn.mousika

class Label extends Content {

    String labelContent

    static constraints = {
        labelContent blank: false
    }

    static searchable = true

    static mapping = {
        labelContent column: 'labelContent', sqlType: 'text'
    }
}
