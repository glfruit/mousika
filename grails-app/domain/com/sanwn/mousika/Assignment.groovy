package com.sanwn.mousika

import com.sanwn.mousika.domain.Content

/**
 * 代表作业的概念
 */
class Assignment extends Content {

    /**
     * 作业类型，目前支持三种：
     * 在线：online
     * 文件：file
     * 离线：offline
     */
    String style

    /**
     * 作业开始日期
     */
    Date availableFrom

    /**
     * 作业到期日期
     */
    Date dueDate

    /**
     * 是否允许逾期提交
     */
    boolean lateSubmitAllowed

    /**
     * 如是文件作业的话，代表学生提交的文件的路径
     */
    String filePath

    static constraints = {
        filePath nullable: true, blank: false
        availableFrom nullable: true
        dueDate nullable: true
    }
}
