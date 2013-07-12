package com.sanwn.mousika.grails

class MousikaTagLib {

    static namespace = "mousika"

    /**
     * 显示版权信息
     *
     * @emptyTag
     */
    def copyright = { attrs, body ->
        def company = message(code: 'default.company.name')
        def copyMsg = "&copy; $company 2013"
        def year = GregorianCalendar.newInstance().get(GregorianCalendar.YEAR)
        if (year - 2013 > 0) {
            copyMsg = copyMsg + "-" + year
        }
        out << copyMsg
    }

    def hello = { attrs, body ->
        out << "Hello ${attrs.name ?: 'World'}"
    }
}
