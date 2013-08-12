package com.sanwn.mousika

import grails.converters.JSON
import org.apache.commons.io.FileUtils
import org.apache.shiro.SecurityUtils
import org.springframework.dao.DataIntegrityViolationException
import org.springframework.web.multipart.commons.CommonsMultipartFile

import java.text.SimpleDateFormat

class StudentController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def gsonBuilder

    def courses, myCourses, notRegCourses
    Map<Course, List<Assignment>> assignments
    def fileRepository;

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

//        myCourses = Course.findAll() {
//            deliveredBy == loginUser
//        }

        def courseApplications = CourseApplication.findAll(){
            applicant == loginUser && (status =="approved"||status=="submitted")
        }

//        myCourses = Course.findAll() {
//            courseMembers.user == loginUser
//        }
        myCourses = new ArrayList();
        for(CourseApplication ca :courseApplications){
            if(ca.status =="approved")
            myCourses.add(ca.applyFor)
        }

        notRegCourses = new ArrayList();
        boolean isReg = false;
        for (Course c : courses) {
            isReg = false
            for (Course m : myCourses) {
                if (c.id == m.id) {
                    isReg = true;
                }
            }

            if (!isReg) {
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

//        assignments = Assignment.list([sort: 'section', order: 'asc']);
        //type=="com.sanwn.mousika.Assignment";
//        assignments = Assignment.findAll("from Assignment as a order by section asc");
        fileRepository = FileRepository.findAll(){
            owner == loginUser
        };
        //assignments = Assignment.list()

        assignments = new HashMap<>();
        Course key=null
        List<Assignment> assignmentList = null;
        for(Course course:myCourses){
            assignmentList = null;
            for(CourseUnit courseUnit:course.units){
                for(UnitItem unitItem:courseUnit.items){
                    if(unitItem.content instanceof  Assignment){
                        Assignment a = unitItem.content
                        if(new Date()<=a.dueDate){
                            if(assignmentList==null)
                                assignmentList = new ArrayList()
                            assignmentList.add((Assignment)unitItem.content)
                        }
                    }
                }
            }
            if(key==null||key.id!=course.id){
                assignments.put(course,assignmentList)
            }
        }
        return
    }

    def works() {
        def count
        if (isStudent) {
//            count = Course.createCriteria().count {
//                'in'('id', myCourses.id)
//            }
        }

        [courselist: courses, myCourses: myCourses, notRegCourses: notRegCourses, assignments: assignments,fileRepository:fileRepository]
    }

    def myCourseList() {
        render myCourses as JSON
        //[myCourses: myCourses]
    }

    def assignment() {
        def assignment = Assignment.findById(params.assignmentId);

        [courselist: courses, myCourses: myCourses, notRegCourses: notRegCourses, assignment: assignment]
    }

    def assignmentList() {
        [courselist: courses, myCourses: myCourses, notRegCourses: notRegCourses, assignments: assignments]
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
                deliveredBy == user
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
        [myCourses: myCourses, notRegCourses: notRegCourses]
    }

    def regCourse() {
        def user = User.findByUsername(SecurityUtils.subject.principal)
        def courseId = params.courseId;
        if (courseId != null) {
            def course = Course.findById(courseId);
            CourseApplication application =
                new CourseApplication(applicant: user, applyFor: course, applyDate: new Date(), status: CourseApplication.STATUS_SUBMITTED)

//            def sRole =  Role.findByName("学生")
//            def cm = CourseMember.findByCourseAndUserAndRole(course,loginUser,sRole);
//            if(cm!=null){
//            }else {
//                cm  = new CourseMember();
//                cm.setRole(sRole)
//            }
//            cm.setCourse(course)
//            cm.setUser(loginUser)
//            cm.setStatus(1);
//            cm.save();

            if (application.save(flush: true)) {
                redirect(action: "regCourseList", params: params)
                return
            } else {
                flash.message = "申请课程失败，请稍后重试"
            }
        }
        redirect(action: "regCourseList", params: params)
    }

    def save() {
        params.startDate = params.date('startDate')
        def startDate = params.startDate
        def courseInstance = new Course(params)
        def section = new CourseUnit(sequence: 0, title: '')
        courseInstance.addToSections(section)
        for (i in 0..courseInstance.numberOfWeeks) {
            section = new CourseUnit(sequence: i + 1, title: (startDate + i * 7).toString() + "-" + (startDate + i * 7 + 6).toString()) //TODO:重构;第一个章节添加一个默认新闻讨论区
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

    def resource(Long id) {
        def assignment = Assignment.get(id)
        if (!assignment) {
            flash.message = "未找到指定的作业"
            redirect(action: 'list')
            return
        }
        def attempt = Attempt.where {
            submittedBy == loginUser && assignment == assignment
        }.list()

        [assignment: assignment, attempt: attempt, courselist: courses, myCourses: myCourses, notRegCourses: notRegCourses]
    }

    boolean uploadedFile(Assignment assignment, CommonsMultipartFile uploadedFile){
        boolean result = false
        def filename = uploadedFile.originalFilename
        def filePath = "courseFiles/assignment/"+loginUser.id+"/"+assignment.id
        def fileRepo = new File(".", filePath)
        if (!fileRepo.exists()) {
            FileUtils.forceMkdir(fileRepo)
        }
        def newFile = new File(fileRepo, filename)
        uploadedFile.transferTo(newFile)
        def fileType
        def pos = filename.lastIndexOf('.')
        if (pos == -1) {
            fileType = '*' //unknown file type
        } else {
            fileType = filename.substring(pos + 1)
        }
        try {
            assignment.setFilePath(filePath+"/"+filename)
            //assignment.save()
            result = true
        } catch (Exception e) {
            newFile.delete()
            flash.message = e.message
        }

        return result
    }


    def createAttempt() {
        def attempt;
        def assignment = Assignment.get(params.assignmentId)
        def file = request.getFile('assignmentFile')
        if (assignment.attempts != null && assignment.attempts.size() > 0) {
            attempt = assignment.attempts.first()
            attempt.attemptContent = params.attemptContent
        } else {
            attempt = new Attempt(params)
            attempt.submittedBy = loginUser
            attempt.score = 0
            attempt.submittedDate = new Date()
            assignment.addToAttempts(attempt)
        }

        if (attempt.validate() &&assignment.save()&&(file.size==0||(file.size>0&&uploadedFile(assignment,file)))) {
            flash.message = "保存答案成功"
            redirect(action: 'resource', id: assignment.id)
            return
        }
        flash.message = "保存答案失败"
        render(view: 'resource', model: [assignment: assignment, attempt: attempt])
    }

    def page(Long id) {
        def pageInstance = Page.get(id)
        if (!pageInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'page.label', default: 'Page'), id])
            //redirect(action: "list")
            return
        }

        [pageInstance: pageInstance, courselist: courses, myCourses: myCourses, notRegCourses: notRegCourses]
    }

    def show(Long id) {
        def courseInstance = Course.get(id)
        if (!courseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'course.label', default: 'Course'), id])
            redirect(action: "list")
            return
        }

//        def courses, count, myCourses
//        def user = User.findByUsername(SecurityUtils.subject.principal)
//        courses = Course.findAll() {
//            courseMembers.user == user
//        }
//        count = Course.createCriteria().count {
//            'in'('id', courses.id)
//        }

        [courseInstance: courseInstance, courselist: courses, myCourses: myCourses, notRegCourses: notRegCourses]
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

    def fileList(Integer max){
        SecurityUtils.subject.session.setAttribute(FileRepository.REPOSITORY_TYPE, FileRepository.REPOSITORY_TYPE_FILE)
        SecurityUtils.subject.session.setAttribute(FileRepository.REPOSITORY_PATH, SecurityUtils.subject.principal)

        params.max = Math.min(max ?: 10, 100)
        [fileRepositoryInstanceList: FileRepository.list(params), fileRepositoryInstanceTotal: FileRepository.count()]
    }
}
