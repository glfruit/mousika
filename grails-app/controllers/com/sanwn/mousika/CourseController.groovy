package com.sanwn.mousika

import org.apache.shiro.SecurityUtils
import org.compass.core.engine.SearchEngineQueryParseException
import org.springframework.dao.DataIntegrityViolationException

class CourseController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def gsonBuilder

    def searchableService

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        params.sort = params.sort ?: 'title'
        params.offset = params.offset ?: 0

        def isAdmin = SecurityUtils.subject.hasRole(Role.ADMIN)
        def courses, total
        if (isAdmin) {
            courses = Course.list(params)
            total = Course.count()
        } else {
            courses = Course.where {
                deliveredBy.username == SecurityUtils.subject.principal
            }.list(params)
            total = Course.createCriteria().count {
                'in'('id', courses.id)
            }
        }

        [courseInstanceList: courses, courseInstanceTotal: total]
    }

    def listPublic() {
        params.max = 10
        params.sort = 'title'
        params.offset = 0
        def courses
        if (SecurityUtils.subject.authenticated) {
            courses = Course.list(params)
        } else
            courses = Course.findAllByGuestVisible(true, params)
        withFormat {
            html courses: courses
            json {
                def results = courses.collect { course ->
                    [
                            id: course.id,
                            title: course.title,
                            teacher: course.courseMembers.find { memeber -> memeber.role.name == "教师" },
                            description: course.description
                    ]
                }
                results.each {
                    it.teacher = it.teacher ? it.teacher.user.fullname : ''
                }
                render(contentType: 'text/json', text: gsonBuilder.create().toJson(results))
            }
        }
    }

    def create() {
        [courseInstance: new Course(params)]
    }

    def save() {
        params.startDate = params.date('startDate')
        def startDate = params.startDate
        def courseInstance = new Course(params)
        def unit = new CourseUnit(sequence: 0, title: '')
        courseInstance.addToUnits(unit)
        for (i in 0..courseInstance.numberOfWeeks) {
            unit = new CourseUnit(sequence: i + 1, title: (startDate + i * 7).toString() + "-" + (startDate + i * 7 + 6).toString()) //TODO:重构;第一个章节添加一个默认新闻讨论区
            courseInstance.addToUnits(unit)
        }

        try {
            if (!courseInstance.save(flush: true)) {
                log.error("添加课程${courseInstance.title}失败:${courseInstance.errors.fieldError.defaultMessage}")
                render(view: "create", model: [courseInstance: courseInstance])
                return
            }
        }
        catch (DataIntegrityViolationException e) {
            log.error("系统错误:${e}",)
            flash.message = "系统内部错误"
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
        params.max = Math.min(params.max ?: 2, 100)
        params.offset = params.offset ?: 0
        params.sort = 'username'
        params.order = 'asc'
        def userCount = User.count()
        def course = Course.get(id)
        def members = course.deliveredBy ? [course.deliveredBy] : []
        members.addAll(course.students)
        [users: User.list(params), members: members,
                userCount: userCount, pages: Math.ceil(userCount / params.max), offset: params.offset]
    }

    def assign(Long id) {
        def course = Course.get(id)
        def user = User.get(params.uid)
        def role = Role.get(params.rid)
        user.addToRoles(role)
        if ("学生" == role.name) {
            course.addToStudents(user)
            user.addToPermissions("course:show:${id}")
        } else if ("教师" == role.name) {
            course.deliveredBy = user
            user.addToPermissions("course:*:${id}")
        }
        course.save(flush: true)
        render(contentType: "text/json") {  //TODO: handle failure
            [success: !course.hasErrors()]
        }
    }

    def listMembers(Long id) {
        def course = Course.get(id)
        def members = course.deliveredBy ? [course.deliveredBy] : []
        members.addAll(course.students)
        withFormat {
            html {
                [members: members, courseId: course.id]
            }
            json {
                def json = members.collect { member ->
                    [
                            username: member.username,
                            fullname: member.fullname,
                            email: member.profile?.email,
                            lastAccessed: member.profile?.lastAccessed,
                            roles: member.roles.collect { [id: it.id, name: it.name] }
                    ]
                }
                def gson = gsonBuilder.create()
                render contentType: "text/json", text: gson.toJson(json)
            }
        }
    }

    def addResource() {
        def contentType = params.itemContentType
        redirect(controller: contentType, action: 'create', params: [sectionSeq: params.sectionSeq, courseId: params.courseId])
    }

    def listMaterials(Long id) {
        SecurityUtils.subject.session.setAttribute(FileRepository.REPOSITORY_TYPE, FileRepository.REPOSITORY_TYPE_COURSE)
        def course = Course.get(id)
        if (!course) {
            throw new IllegalArgumentException("未找到id为${id}的课程")
        }
        def token = course.courseToken
        SecurityUtils.subject.session.setAttribute(FileRepository.REPOSITORY_PATH, token)
        redirect(controller: 'fileRepository', action: 'list')
    }

    def search() {
        if (!params.q?.trim()) {
            return [:]
        }
        try {
            return [searchResult: Course.search(params.q, params)]
        } catch (SearchEngineQueryParseException ex) {
            return [parseException: true]
        }
    }
}
