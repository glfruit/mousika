package com.sanwn.mousika
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
    String style = 'online'

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

    static searchable = true

    static mapping = {
        attempts sort: 'submittedDate', order: 'desc'
    }

    static constraints = {
        filePath nullable: true, blank: false
        availableFrom nullable: true
        dueDate nullable: true
        lateSubmitAllowed nullable: true
    }

    static hasMany = [attempts: Attempt]

    def copy() {
        new Assignment(title: title, description: description, style: style)
    }

    boolean isSubmitAttempt(){
        Date date = new Date();
        boolean isSubmit =  false
        //isSubmit = availableFrom<=date&&date<=dueDate
        isSubmit = attempts?.size()>0&&attempts.first().feedback!=null

        return isSubmit
    }
}
