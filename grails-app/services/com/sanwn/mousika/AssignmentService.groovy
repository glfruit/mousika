package com.sanwn.mousika

class AssignmentException extends RuntimeException {

    String message

    Assignment assignment
}

class AssignmentService {

    def createAssignment(Assignment assignment) {
        if (!assignment.save()) {
            throw new AssignmentException(message: "创建作业错误", assignment: assignment)
        }
        return assignment
    }
}
