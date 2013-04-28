package com.sanwn.mousika

import com.sanwn.mousika.domain.Content

class Label extends Content {

    String labelContent

    static constraints = {
        labelContent blank: false
    }

    static mapping = {
        labelContent column: 'labelContent', sqlType: 'text'
    }
}
