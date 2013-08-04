package com.sanwn.mousika

/**
 * 代表一门课程的一个教学单元
 */
class CourseUnit {

    int sequence

    String title

    static searchable = true

    static belongsTo = [course: Course]

    static hasMany = [items: UnitItem]

    static constraints = {
    }

    static mapping = {
        sort sequence: 'asc'
        items sort: "sequence", order: "asc"
    }

    def copy(Course course) {
        def unit = new CourseUnit(title: title, sequence: sequence)
        items.each { unitItem ->
            def itemCopy = unitItem.copy()
            if (unitItem.content instanceof Forum)
                itemCopy.content = course.forum
            unit.addToItems(itemCopy)
        }
        return unit
    }
}
