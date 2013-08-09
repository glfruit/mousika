package com.sanwn.mousika

import org.apache.shiro.SecurityUtils
import org.compass.core.engine.SearchEngineQueryParseException
import org.springframework.dao.DataIntegrityViolationException

import java.text.SimpleDateFormat

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
            def deliveredBy = User.where {
                username == SecurityUtils.subject.principal
            }.find()
            courses = Course.where {
                deliveredBy == deliveredBy
            }.list(params)
            total = Course.countByDeliveredBy(deliveredBy)
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
            html {
                courses: courses
            }
            json {
                def results = courses.collect { course ->
                    [
                            id: course.id,
                            title: course.title,
                            teacher: course.deliveredBy?.fullname,
                            description: course.description
                    ]
                }
                render(contentType: 'text/json', text: gsonBuilder.create().toJson(results))
            }
        }
    }

    def listMine() {
        def username = SecurityUtils.subject.principal
        def user = User.where {
            username == username
        }.find()
        def courses = Course.where {
            deliveredBy == user //TODO: 加上课程是否仍有效的过滤条件
        }.list(order: 'courseToken')
//        withFormat {
//            html {
//                [courses: courses]
//            }
//            json {
        def result = courses.collect { course ->
            [
                    id: course.id,
                    title: course.title,
                    type: 'course',
                    units: course.units.collect { unit ->
                        [
                                id: unit.id,
                                title: unit.title,
                                type: 'unit',
                                parentId: course.id,
                                unitItems: unit.items.collect { unitItem ->
                                    [
                                            id: unitItem.id,
                                            title: unitItem.title,
                                            type: 'unitItem',
                                            parentId: unit.id
                                    ]
                                }
                        ]
                    }
            ]
        }
        render contentType: 'text/json', text: "{identifier:'id',label:'title',items:${gsonBuilder.create().toJson(result)}}"
//            }
//        }
    }

    def examine(Long id) {
        params.sort = params.sort ?: 'applyDate'
        params.max = params.max ?: 20
        def course = Course.get(id)
        def applications = CourseApplication.where {
            applyFor == course && status == CourseApplication.STATUS_SUBMITTED
        }.list(params)
        def total = CourseApplication.countByApplyForAndStatus(course, CourseApplication.STATUS_SUBMITTED)
        [applications: applications, total: total]
    }

    def approve(Long id) {
        def updated, approved
        if (params.boolean('batch')) {
            approved = params.list('examine')
            approved = approved.collect {
                it as Long
            }
            def query = CourseApplication.where {
                id in approved
            }
            updated = query.updateAll(status: params.status, approveDate: new Date())
        } else {
            approved = params.examine
            def application = CourseApplication.where {
                id == approved
            }.find()
            application.status = params.status//TODO: 重构进service里
            application.approveDate = new Date()
            if (application.save(flush: true)) {
                updated = 1
            }
        }
        if (updated > 0) {
            def applications = CourseApplication.where {
                applyFor.id == id && status == CourseApplication.STATUS_SUBMITTED
            }.list(params)
            def json = applications.collect {
                [
                        id: it.id,
                        applicantId: it.applicant.id,
                        applicantName: it.applicant.fullname,
                        applyDate: it.applyDate
                ]
            }
            render contentType: 'application/json', text: '{"success":true,"applications":' + gsonBuilder.create().toJson(json) + '}'
        } else
            render contentType: 'application/json', text: '{"success":false}'
    }

    def create() {
        [courseInstance: new Course(params)]
    }

    def copy(Long id) {
        def course = Course.get(id)
        [copied: new Course(startDate: course.startDate, available: course.available,
                guestVisible: course.guestVisible), courseId: id]
    }

    def editCopy(Long id) {
        [courseInstance: Course.get(id)]
    }

    def saveCopy() {
        def course = Course.get(params.courseId).copy()
        params.startDate = params.date('startDate')
        course.properties = params
        def username = SecurityUtils.subject.principal
        def user = User.where {
            username == username
        }.find()
        course.deliveredBy = user
        if (!course.save(flush: true)) {
            log.error("导入课程失败")
            flash.message = "导入课程失败"
            render(view: "copy", model: [copied: course, courseId: params.courseId])
            return
        }
        redirect(action: 'editCopy', id: course.id)
    }

    def copyResource() {

    }

    def save() {
        params.startDate = params.date('startDate')
        def courseInstance = new Course(params)
        courseInstance.init()

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
            redirect(action: "show", id: id)
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

        params.startDate = params.date('startDate')
        def numberOfWeeks = courseInstance.numberOfWeeks
        courseInstance.properties = params
        if (courseInstance.numberOfWeeks > numberOfWeeks) {
            def startDate = courseInstance.startDate
            def formatter = new SimpleDateFormat("yyyy-MM-dd")
            def title, unit
            for (i in numberOfWeeks + 1..courseInstance.numberOfWeeks) {
                def d = startDate + i * 7
                title = formatter.format(d) + '-' + formatter.format(d + 6)
                unit = new CourseUnit(sequence: i, title: title) //TODO:重构;第一个章节添加一个默认新闻讨论区
                courseInstance.addToUnits(unit)
            }
        }

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
        params.max = Math.min(params.max ?: 20, 100)
        params.offset = params.offset ?: 0
        params.sort = 'username'
        params.order = 'asc'
        def userCount = User.count()
        def course = Course.get(id)
        def members = course.deliveredBy ? [course.deliveredBy] : []
        members.addAll(course.students)
        def registered = course.students.size()
        def applied = CourseApplication.countByApplyForAndStatus(course, CourseApplication.STATUS_SUBMITTED)
        [users: User.list(params), members: members,
                userCount: userCount, pages: Math.ceil(userCount / params.max), offset: params.offset, registered: registered, applied: applied]
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
                            id: member.id,
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
        [course: course]
    }

    def search() {
        if (!params.q?.trim()) {
            return [:]
        }
        try {
            if ("resource" == params.type) {
                def searchResult = UnitItem.search(params.q, params)
                render view: 'searchResource', model: [searchResult: searchResult]
                return
            }
            return [searchResult: Course.search(params.q, params)]
        } catch (SearchEngineQueryParseException ex) {
            return [parseException: true]
        }
    }

    def grade(Long id) {
        params.max = params.max ?: 20;
        params.offset = params.offset ?: 0;
        def course = Course.get(id)
        def query = UnitItem.createCriteria()
        def items = query.list(params) {
            'in'('unit', course.units)
            createAlias("unit", "_unit")
            order("_unit.sequence")
            order("sequence")
        }
        items = items.findAll {
            it.content.type == 'assignment'
        }
        def total = 10 //TODO: 获取totoal总数
        [assignments: items, course: course, total: total]
    }

    def toggleUnitOrItem(Long courseId, int unitSeq, int itemSeq) {
        def course = Course.get(courseId)
        if (!course) {
            render contentType: 'application/json', text: "{\"success\":false,\"error\":\"未找到id为${courseId}的课程\"}"
            return
        }
        def unit = CourseUnit.where {
            course == course && sequence == unitSeq
        }.find()
        if (!unit) {
            render contentType: 'application/json', text: "{\"success\":true,\"error\":\"未在id为${courseId}的课程里找到序列号为${unitSeq}的课程单元\"}"
            return
        }
        if (itemSeq == -1) {
            unit.visible = params.boolean('visible')
            if (unit.save(flush: true)) {
                render contentType: 'application/json', text: '{"success":true}'
            } else {
                render contentType: 'application/json', text: '{"success":false,"error":"更新失败"}'
            }
        } else {
            def unitItem = UnitItem.where {
                unit == unit && sequence == itemSeq
            }.find()
            if (!unitItem) {
                render contentType: 'application/json',
                        text: "{\"success\":false,\"error\":\"未在id为${courseId}的课程序列号为${unitSeq}的课程单元里找到${itemSeq}的课程内容\"}"
                return
            }
            unitItem.visible = params.boolean('visible')
            if (unitItem.save(flush: true)) {
                render contentType: 'application/json', text: '{"success":true}'
            } else {
                render contentType: 'application/json', text: '{"success":false,"error":"更新失败"}'
            }
        }
    }
}
