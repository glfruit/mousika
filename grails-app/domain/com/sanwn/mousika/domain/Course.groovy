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

    String author

    static constraints = {
    }
}
