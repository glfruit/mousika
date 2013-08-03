package com.sanwn.mousika

/**
 * 课程学习申请
 *
 * @author glix
 * @version 1.0
 *
 */
class CourseApplication {

    public static String STATUS_APPROVED = "approved" //批准

    public static String STATUS_DENIED = "denied" //驳回

    public static String STATUS_SUBMITTED = "submitted" //已提交

    static mapping = {
        table 'mousika_course_applications'
    }

    static constraints = {
        approveDate nullable: true
        feedback nullable: true
    }

    /**
     * 申请者
     */
    User applicant

    /**
     * 申请学习的课程
     */
    Course applyFor

    /**
     * 申请日期
     */
    Date applyDate

    /**
     * 批准时间
     */
    Date approveDate

    /**
     * 申请状态
     */
    String status

    /**
     * 审批意见
     */
    String feedback
}
