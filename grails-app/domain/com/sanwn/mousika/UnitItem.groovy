package com.sanwn.mousika

/**
 * 代表一个课程单元里的一项内容
 */
class UnitItem {

    String itemName

    int sequence

    Content content

    static belongsTo = [unit: CourseUnit]

    static constraints = {
    }
}
