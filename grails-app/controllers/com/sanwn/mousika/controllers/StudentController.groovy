package com.sanwn.mousika.controllers

import com.sanwn.mousika.*
import org.apache.shiro.SecurityUtils
import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class StudentController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def gsonBuilder

    def courses, myCourses, notRegCourses
    def assignments

    User loginUser
    boolean isStudent

    def index() {
        redirect(action: "works", params: params)
    }

    /**
     * 数据准备（通用）：0：全部;1:已注册;2:未注册
     * @param search
     * @return
     */
    def beforeInterceptor = {  //before返回false，后续action不执行
        loginUser = User.findByUsername(SecurityUtils.subject.principal)
        isStudent = SecurityUtils.subject.hasRole(Role.STUDENT)

        courses = Course.findAll() {
        }

        myCourses = Course.findAll() {
            courseMembers.user == loginUser
        }

//        notRegCourses = Course.findAll() {
//            courseMembers.user != loginUser
//        }

        notRegCourses = new ArrayList();
        boolean isReg = false;
        for(Course c:courses){
            isReg = false
            for(Course m:myCourses){
                if(c.id==m.id){
                    isReg = true;
                }
            }

            if(!isReg){
                notRegCourses.add(c)
            }
        }
//        for(int i=notRegCourses.size()-1;i>=0;i--){
//            Course c = notRegCourses.get(i);
//            if(c.courseMembers!=null&&c.courseMembers.size()>0) {
//                for(CourseMember cm:c.courseMembers.toArray()){
//                    if(cm.user.id==user.id){
//                        notRegCourses.remove(c)
//                        break;
//                    }
//                }
//            }
//        }

        assignments = Assignment.list([sort: 'section',order: 'asc']);
            //type=="com.sanwn.mousika.Assignment";
        assignments = Assignment.findAll("from Assignment as a order by section asc");
    }

    def works() {
        def count
        if (isStudent) {
            count = Course.createCriteria().count {
                'in'('id', myCourses.id)
            }
        }

        [courselist:courses, myCourses: myCourses, notRegCourses:notRegCourses, assignments:assignments]
    }

    def assignment() {
        def assignment = Assignment.findById(params.assignmentId);

       [courselist:courses, myCourses: myCourses, notRegCourses:notRegCourses, assignment:assignment]
    }
    def assignmentList() {
        [courselist:courses, myCourses: myCourses, notRegCourses:notRegCourses, assignments:assignments]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        params.sort = params.sort ?: 'title'
        params.offset = params.offset ?: 0

        def isStudent = SecurityUtils.subject.hasRole(Role.STUDENT)
        def courses, count, myCourses
        if (isStudent) {
            def user = User.findByUsername(SecurityUtils.subject.principal)
            courses = Course.findAll([max: params.max, sort: params.sort, offset: params.offset]) {
                courseMembers.user == user
            }
            count = Course.createCriteria().count {
                'in'('id', courses.id)
            }
        }

        [courseList: courses, total: courses.size()]
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

    def regCourseList() {
        [myCourses: myCourses, notRegCourses:notRegCourses]
    }

    def regCourse() {
        def user = User.findByUsername(SecurityUtils.subject.principal)
        def courseId = params.courseId;
        if(courseId != null){
            def course = Course.findById(courseId);
            def role = Role.findByName("学生")

            if(course != null){
                CourseMember cm = new CourseMember();
                cm.setUser(user)
                cm.setCourse(course)
                cm.setRole(role)
                cm.save();
            }
        }
        redirect(action: "regCourseList", params: params)
    }

    def save() {
        params.startDate = params.date('startDate')
        def startDate = params.startDate
        def courseInstance = new Course(params)
        def section = new CourseSection(sequence: 0, title: '')
        courseInstance.addToSections(section)
        for (i in 0..courseInstance.numberOfWeeks) {
            section = new CourseSection(sequence: i + 1, title: (startDate + i * 7).toString() + "-" + (startDate + i * 7 + 6).toString()) //TODO:重构;第一个章节添加一个默认新闻讨论区
            courseInstance.addToSections(section)
        }

        if (!courseInstance.save(flush: true)) {
            log.error("添加课程${courseInstance.title}失败:${courseInstance.errors.fieldError.defaultMessage}")
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

        def courses, count, myCourses
        def user = User.findByUsername(SecurityUtils.subject.principal)
        courses = Course.findAll() {
            courseMembers.user == user
        }
        count = Course.createCriteria().count {
            'in'('id', courses.id)
        }

        [courseInstanceList: courses, courseInstanceTotal: courses.size(),courseInstance: courseInstance]
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

    def assign(Long courseId) {
        def course = Course.get(courseId)
        def user = User.get(params.uid)
        def role = Role.get(params.rid)
        user.addToRoles(role)
        if ("学生" == role.name) {
            user.addToPermissions("course:show:${courseId}")
        }
        def member = new CourseMember(user: user, role: role)
        course.addToCourseMembers(member)
        course.save(flush: true)
        render(contentType: "text/json") {  //TODO: handle failure
            [success: !course.hasErrors()]
        }
    }

    def listMembers(Long id) {
        def course = Course.get(id)
        def members = CourseMember.where {
            course.id == id
        }.order('role').order('user').list().user
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
}
