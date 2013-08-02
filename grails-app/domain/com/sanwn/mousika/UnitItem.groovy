package com.sanwn.mousika

/**
 * 代表一个课程单元里的一项内容
 */
class UnitItem {

    String title

    int sequence

    Content content

    static searchable = true

    static belongsTo = [unit: CourseUnit]

    static mapping = {
        sort sequence: 'asc'
    }

    def copy() {
        def c = content
        if (c instanceof Assignment) {
            c = (c as Assignment).copy()
        }
        //TODO: 拷贝文件资源时应当将相应的文件也拷贝过去
        new UnitItem(title: title, sequence: sequence, content: c)
    }
}
