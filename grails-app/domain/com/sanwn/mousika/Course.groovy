package com.sanwn.mousika

/**
 * 描述一门课程的基本信息
 *
 * @author glix
 * @since 1.0
 * @version 1.0
 */
class Course {

    /**
     * 课程标识符，唯一标明一位教师教授的一门课程
     */
    String courseToken

    /**
     * 课程名称
     */
    String title

    /**
     * 课程代码
     */
    String code

    /**
     * 课程描述
     */
    String description

    Date startDate

    /**
     * 是否访客可见
     */
    boolean guestVisible

    /**
     * 是否允许学生学习
     */
    boolean available

    /**
     * 授课周数
     */
    int numberOfWeeks

    /**
     * 授课教师
     */
    User deliveredBy

    SortedSet students

    static searchable = true

    static hasMany = [students: User, units: CourseUnit]


    static constraints = {
        courseToken unique: true, blank: false
        code blank: false
        title blank: false
        deliveredBy nullable: true
        description nullable: true
    }

    static mapping = {
        description column: "description", sqlType: "text"
        units sort: "sequence", order: "asc"
    }

    def init() {
        def unit = new CourseUnit(sequence: 0, title: '')
        this.addToUnits(unit)
        for (i in 0..numberOfWeeks - 1) {
            unit = new CourseUnit(sequence: i + 1, title: (startDate + i * 7).toString() + "-" + (startDate + i * 7 + 6).toString()) //TODO:重构;第一个章节添加一个默认新闻讨论区
            addToUnits(unit)
        }
    }
}
