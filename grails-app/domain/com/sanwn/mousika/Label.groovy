package com.sanwn.mousika

import com.sanwn.mousika.Content

class Label extends Content {

    String labelContent

    static constraints = {
        labelContent blank: false
    }

    static mapping = {
        labelContent column: 'labelContent', sqlType: 'text'
    }
}
