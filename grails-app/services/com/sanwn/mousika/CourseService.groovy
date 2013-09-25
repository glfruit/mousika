package com.sanwn.mousika

import org.springframework.dao.DataIntegrityViolationException

/**
 *
 * @author glix
 * @version 1.0
 *
 */
class CourseService {

    static transactional = true

    def createCourse() {
        def course = new Course()
        if (course.validate() && course.save()) {
            return course
        } else {
            throw new CourseException(message: "Error creating course ${course.title}")
        }
    }

    def switchUnits(sourceUnit, targetUnit) {
        def oldSeq = sourceUnit.sequence
        def newSeq = targetUnit.sequence
        targetUnit.sequence = oldSeq
        sourceUnit.sequence = newSeq
        sourceUnit.reindex()
        targetUnit.reindex()
    }

    def removeUnit(CourseUnit courseUnit) {
        def course = courseUnit.course
        try {
            course.numberOfWeeks = course.numberOfWeeks - 1
            course.units.each { unit ->
                if (unit.sequence > courseUnit.sequence) {
                    unit.sequence = unit.sequence - 1
                }
            }
            course.removeFromUnits(courseUnit)
            courseUnit.delete(flush: true)
            course.save(flush: true)
            courseUnit.reindex()
        } catch (DataIntegrityViolationException e) {
            throw new CourseException(message: "删除课程单元${courseUnit.title}失败", course: course)
        }
    }

    def addStudents(Course course, User user) {
        addMember(course, user, Role.STUDENT, "course:show:${course.id}")
        course.addToStudents(user)
        course.save()
    }

    def addTeacher(Course course, User user) {
        addMember(course, user, Role.TEACHER, "course:*:${course.id}")
        course.deliveredBy = user
        course.save()
    }

    def removeTeacher(Course course, User user) {
        removeMember(course, user, Role.TEACHER, "course:*:${course.id}")
        course.deliveredBy = null
        course.save()
    }

    def removeStudent(Course course, User user) {
        removeMember(course, user, Role.STUDENT, "course:show:${course.id}")
        def u = course.students.find {
            it.id == user.id
        }
        course.students.remove(u)
        course.save()
    }

    private def removeMember(Course course, User user, String roleName, String permissions) {
        def context = CourseContext.where {
            course == course
        }.find()
        if (context) {
            def role = Role.where {
                context == context && name == roleName
            }.find()
            if (role) {
                user.removeFromRoles(role)
                user.removeFromPermissions(permissions)
                user.save()
            }
        }
    }

    private def addMember(Course course, User user, String roleName, String permissions) {
        def context = CourseContext.where {
            course == course
        }.find()
        if (!context) {
            context = new CourseContext(course: course)
            if (!context.save()) {
                throw new RuntimeException("Exception yet to be handled")
            } //TODO: 处理保存失败的情况
        }
        def role = Role.findByNameAndContext(roleName, context)
        if (!role) {
            role = new Role(name: roleName, context: context)
            role.addToPermissions(permissions)
            if (!role.save()) {
                throw new RuntimeException("Exception yet to be handled")
            }
        }
        user.addToRoles(role)
        user.save()
    }
}
class CourseException extends RuntimeException {

    String message

    Course course
}