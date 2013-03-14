package com.sanwn.mousika.web.controllers

import com.sanwn.mousika.domain.Course

class CourseController {

    def index() {
        redirect(action: 'list')
    }

    def list() {
        def courses = Course.all
    }
}
