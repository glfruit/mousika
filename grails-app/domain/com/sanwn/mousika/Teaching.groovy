package com.sanwn.mousika

class Teaching {
    Course course

    //课程容量
    Float capability

    //更新频次
    Float frequency

    //作业次数
    Float assignmentTimes

    //批改次数
    Float checkTimes

    //学生这门课程使用时间
    Float time

    static constraints = {
        course blank: false
        capability nullable: true
        frequency nullable: true
        assignmentTimes nullable: true
        checkTimes nullable: true
        time nullable: true
    }

    static mapping = {
        table 'teaching'
    }
}
