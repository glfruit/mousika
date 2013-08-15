package com.sanwn.mousika

/**
 * 表示一门课程中的成员
 *
 * @author glix
 * @since 1.0
 */
class CourseMember {

    /**
     * 用户
     */
    User user

    /**
     * 用户在该门课程中扮演的角色
     */
    Role role

    /**
     * 状态：1审核;2:通过
     */
    Integer status

    static belongsTo = [course: Course]

    static constraints = {
    }
}
