package com.sanwn.mousika

class AssignmentController {

    def create() {
        [assignment: new Assignment(params), sectionSeq: params.sectionSeq, courseId: params.courseId]
    }
}
