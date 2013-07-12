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

    List sections


    static hasMany = [courseMembers: CourseMember, sections: CourseSection]


    static constraints = {
        code blank: false
        title blank: false
        description nullable: true
    }

    static mapping = {
        description column: "description", sqlType: "text"
        sections sort: "sequence", order: "asc"
    }
}
