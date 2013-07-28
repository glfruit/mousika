package com.sanwn.mousika

/**
 * 代表一门课程的一个教学单元
 */
class CourseUnit {

    int sequence

    String title

    static belongsTo = [course: Course]

    static hasMany = [items: UnitItem]

    static constraints = {
    }

    static mapping = {
        sort sequence: 'asc'
    }

    def createUnitItem(Content content) {
        def seq = items == null ? 0 : items.size()
        def item = new UnitItem(sequence: seq, title: content.title, content: content)
        addToItems(item)
    }
}
