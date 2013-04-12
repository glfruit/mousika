package com.sanwn.mousika.controllers

import com.sanwn.mousika.domain.Course
import com.sanwn.mousika.domain.CourseMember
import com.sanwn.mousika.domain.Role
import com.sanwn.mousika.domain.User
import org.apache.shiro.SecurityUtils
import org.springframework.dao.DataIntegrityViolationException

class CourseController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        params.sort = params.sort ?: 'title'
        params.offset = params.offset ?: 0

        def isAdmin = SecurityUtils.subject.hasRole(Role.ADMIN)
        def courses, count
        if (isAdmin) {
            courses = Course.list(params)
            count = Course.count()
        } else {
            def user = User.findByUsername(SecurityUtils.subject.principal)
            courses = Course.findAll([max: params.max, sort: params.sort, offset: params.offset]) {
                courseMembers.user == user
            }
            count = Course.createCriteria().count {
                'in'('id', courses.id)
            }
        }

        def teachers = []
        courses.each { course ->
            teachers << course.courseMembers.find { member ->  //TODO: 一门课程只有一名教师？
                member.role.name == "教师"
            }
        }
        [courseInstanceList: courses, courseInstanceTotal: count, teachers: teachers]
    }

    def create() {
        [courseInstance: new Course(params)]
    }

    def save() {
        def courseInstance = new Course(params)
        if (!courseInstance.save(flush: true)) {
            render(view: "create", model: [courseInstance: courseInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'course.label', default: 'Course'), courseInstance.id])
        redirect(action: "enrol", id: courseInstance.id)
    }

    def show(Long id) {
        def courseInstance = Course.get(id)
        if (!courseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'course.label', default: 'Course'), id])
            redirect(action: "list")
            return
        }

        [courseInstance: courseInstance]
    }

    def edit(Long id) {
        def courseInstance = Course.get(id)
        if (!courseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'course.label', default: 'Course'), id])
            redirect(action: "list")
            return
        }

        [courseInstance: courseInstance]
    }

    def update(Long id, Long version) {
        def courseInstance = Course.get(id)
        if (!courseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'course.label', default: 'Course'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (courseInstance.version > version) {
                courseInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'course.label', default: 'Course')] as Object[],
                        "Another user has updated this Course while you were editing")
                render(view: "edit", model: [courseInstance: courseInstance])
                return
            }
        }

        courseInstance.properties = params

        if (!courseInstance.save(flush: true)) {
            render(view: "edit", model: [courseInstance: courseInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'course.label', default: 'Course'), courseInstance.id])
        redirect(action: "show", id: courseInstance.id)
    }

    def delete(Long id) {
        def courseInstance = Course.get(id)
        if (!courseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'course.label', default: 'Course'), id])
            redirect(action: "list")
            return
        }

        try {
            courseInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'course.label', default: 'Course'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'course.label', default: 'Course'), id])
            redirect(action: "show", id: id)
        }
    }

    def enrol(Long id) {
        params.max = Math.min(params.max ?: 10, 100)
        params.offset = params.offset ?: 0
        params.sort = 'fullname'
        params.order = 'asc'
        def userCount = User.count()
        def course = Course.get(id)
        def members = course.courseMembers.user
        [users: User.list(params), members: members,
                userCount: userCount, pages: userCount / params.max + 1, offset: params.offset]
    }

    def assign(Long id) {
        def course = Course.get(id)
        def user = User.get(params.uid)
        def role = Role.get(params.rid)
        user.addToRoles(role)
        def member = new CourseMember(user: user, role: role)
        course.addToCourseMembers(member)
        course.save(flush: true)
        render(contentType: "text/json") {  //TODO: handle failure
            [success: !course.hasErrors()]
        }
    }

    def listMembers(Long id) {
        def course = Course.get(id)
        def members = course.courseMembers.user
        render(contentType: "text/json") {
            members
        }
    }
}
