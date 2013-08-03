package com.sanwn.mousika

class AssignmentException extends RuntimeException {

    String message

    Assignment assignment
}

class AssignmentService {

    static transactional = true

    def createAssignment(Assignment assignment) {
        if (!assignment.validate() || !assignment.save()) {
            throw new AssignmentException(message: "创建作业错误", assignment: assignment)
        }
        return assignment
    }
}
