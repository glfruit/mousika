package com.sanwn.mousika.domain

/**
 * 描述一门课程的基本信息
 *
 * @author glix
 * @since 1.0
 * @version 1.0
 */
class Course {

    /**
     * 课程代码
     */
    String code

    /**
     * 课程名称
     */
    String title

    /**
     * 课程描述
     */
    String description

    /**
     * 是否访客可见
     */
    boolean guestVisible

    boolean available

    /**
     * 课程开始日期
     */
    Date startDate

    /**
     * 授课周数
     */
    int numberOfWeeks

    static constraints = {
        code blank: false
        title blank: false
        description nullable: true
        startDate min: new Date().clearTime()
        numberOfWeeks min: 0
    }

    static mapping = {
        description column: "description", sqlType: "text"
    }
}
