package com.sanwn.mousika

import org.springframework.dao.DataIntegrityViolationException

class TeachingController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [teachingInstanceList: Teaching.list(params), teachingInstanceTotal: Teaching.count()]
    }

    def create() {
        [teachingInstance: new Teaching(params)]
    }

    def save() {
        def teachingInstance = new Teaching(params)
        if (!teachingInstance.save(flush: true)) {
            render(view: "create", model: [teachingInstance: teachingInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'teaching.label', default: 'Teaching'), teachingInstance.id])
        redirect(action: "show", id: teachingInstance.id)
    }

    def show(Long id) {
        def teachingInstance = Teaching.get(id)
        if (!teachingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'teaching.label', default: 'Teaching'), id])
            redirect(action: "list")
            return
        }

        [teachingInstance: teachingInstance]
    }

    def edit(Long id) {
        def teachingInstance = Teaching.get(id)
        if (!teachingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'teaching.label', default: 'Teaching'), id])
            redirect(action: "list")
            return
        }

        [teachingInstance: teachingInstance]
    }

    def update(Long id, Long version) {
        def teachingInstance = Teaching.get(id)
        if (!teachingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'teaching.label', default: 'Teaching'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (teachingInstance.version > version) {
                teachingInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'teaching.label', default: 'Teaching')] as Object[],
                          "Another user has updated this Teaching while you were editing")
                render(view: "edit", model: [teachingInstance: teachingInstance])
                return
            }
        }

        teachingInstance.properties = params

        if (!teachingInstance.save(flush: true)) {
            render(view: "edit", model: [teachingInstance: teachingInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'teaching.label', default: 'Teaching'), teachingInstance.id])
        redirect(action: "show", id: teachingInstance.id)
    }

    def delete(Long id) {
        def teachingInstance = Teaching.get(id)
        if (!teachingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'teaching.label', default: 'Teaching'), id])
            redirect(action: "list")
            return
        }

        try {
            teachingInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'teaching.label', default: 'Teaching'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'teaching.label', default: 'Teaching'), id])
            redirect(action: "show", id: id)
        }
    }

    def displayWarningCourse(){
        def capabilityValue,frequencyValue,assignmentTimesValue,checkTimesValue,timeValue
        try{
            capabilityValue = params.float("capability")
            if (capabilityValue==null){
                capabilityValue = 0
            }
            frequencyValue = params.float("frequency")
            if (frequencyValue==null){
                frequencyValue = 0
            }
            assignmentTimesValue = params.float("assignmentTimes")
            if (assignmentTimesValue==null){
                assignmentTimesValue = 0
            }
            checkTimesValue = params.float("checkTimes")
            if (checkTimesValue==null){
                checkTimesValue = 0
            }
            timeValue = params.float("time")
            if (timeValue==null){
                timeValue = 0
            }
        }catch(Exception exception){
            flash.message = "预警条件请输入数字"
        }

        def teachingInstanceList = Teaching.where {
                (capability < capabilityValue)  ||
                (frequency < frequencyValue)    ||
                (assignmentTimes < assignmentTimesValue) ||
                (checkTimes < checkTimesValue) ||
                (time < timeValue)
             }.list(order: 'id')

        render(view: "list",model: [teachingInstanceList:teachingInstanceList,teachingInstanceTotal:teachingInstanceList.size()])
    }
}
