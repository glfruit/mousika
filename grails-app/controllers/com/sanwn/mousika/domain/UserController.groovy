package com.sanwn.mousika.domain

import com.sanwn.mousika.User
import org.apache.shiro.crypto.hash.Sha256Hash
import org.springframework.dao.DataIntegrityViolationException
import jxl.*

class UserController {

    private File excelFile
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [userInstanceList: User.list(params), userInstanceTotal: User.count()]
    }

    def create() {
        [userInstance: new User(params)]
    }

    def save() {
        def userInstance = new User(params)
        userInstance.setPasswordHash( new Sha256Hash(userInstance.getUsername()).toHex())
        if (!userInstance.save(flush: true)) {
            render(view: "create", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

    def show(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }

    def edit(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }

    def update(Long id, Long version) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'user.label', default: 'User')] as Object[],
                          "Another user has updated this User while you were editing")
                render(view: "edit", model: [userInstance: userInstance])
                return
            }
        }

        userInstance.properties = params

        if (!userInstance.save(flush: true)) {
            render(view: "edit", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

    def delete(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        try {
            userInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "show", id: id)
        }
    }

    def batchImportIndex(){
    }

    def batchImport(){
        def message=""
        def excelFile = params.get("excelFile")
        if(excelFile != null){
            def workbook = Workbook.getWorkbook(excelFile.getProperties().get("inputStream"));
            def sheet = workbook.getSheet("用户");
            def content
            def username
            def fullname
            def email
            def dateCreated = new Date();
            def passwordHash
            def userInstanceList = new ArrayList<User>()
            for(int row = 2; ; row++){
                username = sheet.getCell(0,row-1).getContents()
                //end为结束标记
                if("end".equals(username)) {
                    break;
                }
                fullname = sheet.getCell(1,row-1).getContents()
                email = sheet.getCell(2,row-1).getContents()
                if (username == null || "".equals(username) || fullname == null || "".equals(fullname)){
                    message += "第二行的用户名或姓名不能为空;"
                    break
                }
                passwordHash = new Sha256Hash("username").toHex()
                def userInstance = new User()
                userInstance.setUsername(username)
                userInstance.setFullname(fullname)
                userInstance.setEmail(email)
                userInstance.setDateCreated(dateCreated)
                userInstance.setPasswordHash(passwordHash)
                userInstanceList.add(userInstance)
            }
            //数据没有问题时才保存
            if ("".equals(message)) {
                try{
                    for(int k=0;k<userInstanceList.size();k++){
                        userInstanceList.get(k).save(failOnError: true)
                    }
                }catch(Exception exception){
                    message += "导入失败！保存数据出现异常。" + exception.getMessage().replace('\'',' ').replace("\"","").replace("\n","");
                }
            }
        }else{
            message += "excel存在问题。"
        }
        [message: message]
        redirect(action: "list")
    }
}
