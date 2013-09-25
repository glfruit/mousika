package com.sanwn.mousika

import jxl.Workbook
import org.apache.shiro.SecurityUtils
import org.apache.shiro.crypto.hash.Sha256Hash
import org.compass.core.engine.SearchEngineQueryParseException
import org.springframework.dao.DataIntegrityViolationException

class UserController {

    private File excelFile
    static allowedMethods = [update: "POST"]

    def gsonBuilder

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        params.sort = "username"
        withFormat {
            html {
                [userInstanceList: User.list(params), userInstanceTotal: User.count()]
            }
            json {
                def json = User.list(params).collect {
                    [
                            id: it.id,
                            username: it.username,
                            fullname: it.fullname,
                            email: it.profile?.email,
                            lastAccessed: it.profile?.lastAccessed,
                            roles: it.roles.collect { [id: it.id, name: it.name] }
                    ]
                }
                def gson = gsonBuilder.create()
                render contentType: "text/json", text: gson.toJson(json)
            }
        }
    }

    def create() {
        [userInstance: new User(params)]
    }

    def save() {
        def userInstance = new User(params)
        userInstance.setPasswordHash(new Sha256Hash(userInstance.getUsername()).toHex())
        if (!userInstance.save(flush: true)) {
            render(view: "create", model: [userInstance: userInstance])
            return
        }

        flash.message = "用户创建成功"
        redirect(action: "show", id: userInstance.id)
    }

    def show(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
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
            flash.message = message(code: 'user.not.found.message', args: [message(code: 'user.label', default: '用户'), id])
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

        flash.message = message(code: 'user.updated.message', args: [message(code: 'user.label', default: '用户'), userInstance.id])
        /*redirect(action: "show", id: userInstance.id)*/
        redirect(action: "list")
    }

    def delete(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'user.not.found.message', args: [message(code: 'user.label', default: '用户'), id])
            redirect(action: "list")
            return
        }

        try {
            userInstance.delete(flush: true)
            flash.message = message(code: 'user.deleted.message', args: [message(code: 'user.label', default: '用户'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'user.not.deleted.message', args: [message(code: 'user.label', default: '用户'), id])
            redirect(action: "show", id: id)
        }
    }

    def batchImportIndex() {
    }

    def batchImport() {
        def errorMessage = ""
        def excelFile = params.get("excelFile")
        if (excelFile != null) {
            def workbook = Workbook.getWorkbook(excelFile.getProperties().get("inputStream"));
            def sheet = workbook.getSheet("用户");
            def content
            def username
            def fullname
            def email
            def roleNames
            def roleNameList
            def dateCreated = new Date();
            def passwordHash
            def userInstanceList = new ArrayList<User>()
            def role
            for (int row = 2; ; row++) {
                username = sheet.getCell(0, row - 1).getContents()
                //end为结束标记
                if ("end".equals(username)) {
                    break;
                }
                fullname = sheet.getCell(1, row - 1).getContents()
                /*email = sheet.getCell(2,row-1).getContents()*/
                if (username == null || "".equals(username) || fullname == null || "".equals(fullname)) {
                    errorMessage += "导入失败：第" + row + "行的用户名或姓名不能为空；"
                    break
                }

                //通过username查看用户是否存在存在就用原来的用户并且删除原来的角色
                def userInstance = User.findByUsername(username)
                if (userInstance != null) {
                    errorMessage += "导入失败：第" + row + "行的用户名已经存在；"
                    break
                } else {
                    userInstance = new User()
                }
                passwordHash = new Sha256Hash("username").toHex()
                userInstance.setUsername(username)
                userInstance.setFullname(fullname)
                userInstance.setDateCreated(dateCreated)
                userInstance.setPasswordHash(passwordHash)

                //角色
                roleNames = sheet.getCell(2, row - 1).getContents()
                if (roleNames != null && !("".equals(roleNames))) {
                    roleNameList = roleNames.split(",")
                    for (int roleNameIndex = 0; roleNameIndex < roleNameList.size(); roleNameIndex++) {
                        role = Role.findByName(roleNameList[roleNameIndex])
                        if (role != null) {
                            userInstance.addToRoles(role)
                        }
                    }
                }

                userInstanceList.add(userInstance)
            }
            //数据没有问题时才保存
            if ("".equals(errorMessage)) {
                try {
                    User.saveAll(userInstanceList)
                    /*for(int k=0;k<userInstanceList.size();k++){
                        userInstanceList.get(k).save(failOnError: true)
                    }*/
                } catch (Exception exception) {
                    errorMessage += "导入失败！保存数据出现异常。" + exception.getMessage().replace('\'', ' ').replace("\"", "").replace("\n", "");
                }
            }
        } else {
            errorMessage += "excel存在问题。"
        }
        if (errorMessage.equals("")) {
            errorMessage += "导入成功"
        }
        flash.message = message(code: errorMessage)
        redirect(action: "batchImportIndex")
    }

    def search() {
        if (!params.q?.trim()) {
            withFormat {
                html {
                    [:]
                }
                json {
                    def users = User.list(sort: "username", max: 10, offset: 0)
                    def results = [
                            total: User.count(),
                            max: users.size(),
                            offset: 0,
                            users: users.collect {
                                [
                                        id: it.id,
                                        username: it.username,
                                        fullname: it.fullname,
                                        email: it.profile?.email,
                                        firstAccessed: it.profile?.firstAccessed,
                                        lastAccessed: it.profile?.lastAccessed,
                                        roles: it.roles.collect { [id: it.id, name: it.name] }
                                ]
                            }
                    ]
                    render contentType: 'text/json', text: gsonBuilder.create().toJson(results)
                }
            }
        } else {
            try {
                def searchResult = User.search(params.q, params)
                withFormat {
                    html {
                        [searchResult: searchResult]
                    }
                    json {
                        def results = [
                                total: searchResult.total,
                                max: searchResult.max,
                                offset: searchResult.offset,
                                users: searchResult.results.collect {
                                    [
                                            id: it.id,
                                            username: it.username,
                                            fullname: it.fullname,
                                            email: it.profile?.email,
                                            firstAccessed: it.profile?.firstAccessed,
                                            lastAccessed: it.profile?.lastAccessed,
                                            roles: it.roles.collect { [id: it.id, name: it.name] }
                                    ]
                                }
                        ]
                        render contentType: 'text/json', text: gsonBuilder.create().toJson(results)
                    }
                }
            } catch (SearchEngineQueryParseException ex) {
                return [parseException: true]
            }
        }
    }

    def assign() {
        log.info("trying to assign a role to user")
        def uid = params.uid
        def rid = params.rid
        try {
            def u = User.findById(uid)
            u.addToRoles(Role.findById(rid))
            render(contentType: "text/json") {
                [success: true]
            }
        } catch (e) {
            log.error("添加角色失败", e)
            render(contentType: "text/json") {
                [success: false, error: e.message]
            }
        }
    }

    def updatePasswordIndex() {
        /*def subject = SecurityUtils.getSubject();
        [subject:subject]*/
    }

    def updatePassword() {
        def subject = SecurityUtils.getSubject();
        def userInstance = User.findByUsername(subject.getPrincipal())
        if (!userInstance.getPasswordHash().equals(new Sha256Hash(params.get("oldPassword")).toHex())) {
            flash.message = message(code: 'user.update.password.error.message')
            redirect(action: "updatePasswordIndex")
        } else {
            userInstance.setPasswordHash(new Sha256Hash(params.get("newPassword1")).toHex())
            userInstance.save(failOnError: true)
            flash.message = message(code: 'user.update.password.success.message')
            redirect(action: "updatePasswordIndex")
        }
    }

    def updateInformationIndex() {
        def subject = SecurityUtils.getSubject();
        def userInstance = User.findByUsername(subject.getPrincipal())
        [userInstance: userInstance]
    }

    def updateInformation() {
        def subject = SecurityUtils.getSubject();
        def userInstance = User.findByUsername(subject.getPrincipal())
        userInstance.profile.email = params.get("email")
        userInstance.profile.interests = params.get("interests")
        try {
            userInstance.save(flash: true)
        }
        catch (Exception exception) {
            flash.message = "email格式错误"
        }
        redirect(action: "updateInformationIndex")
    }

    def uploadPhotoIndex() {

    }

    def uploadPhoto() {
        def propertiesMap = params.get("photo").getProperties()
        def contentType = propertiesMap.get("contentType")
        if (propertiesMap.get("empty")) {
            flash.message = "上传的头像为空"
            redirect(action: "uploadPhotoIndex")
            return
        } else if (!(contentType.equals("image/jpeg") || contentType.equals("image/png") || contentType.equals("image/bmp") || contentType.equals("image/gif"))) {
            flash.message = "不支持的图片格式"
            redirect(action: "uploadPhotoIndex")
            return
        } else if (propertiesMap.get("size") > 200 * 1024) {
            flash.message = "上传的头像太大"
            redirect(action: "uploadPhotoIndex")
            return
        } else {
            FileInputStream fileInputStream = propertiesMap.get("inputStream")
            def subject = SecurityUtils.getSubject();
            def userInstance = User.findByUsername(subject.getPrincipal())
            userInstance.profile.photo = fileInputStream.bytes
            userInstance.save(failOnError: true)
            flash.message = "上传头像成功"
            redirect(action: "uploadPhotoIndex")
        }
    }

    def displayPhoto() {
        def userInstance
        if (params.get("id") != null) {
            userInstance = User.get(params.get("id"))
        } else {
            def subject = SecurityUtils.getSubject();
            userInstance = User.findByUsername(subject.getPrincipal())
        }
        def photoByte
        if (userInstance.getProfile() != null && userInstance.getProfile().getPhoto() != null && userInstance.getProfile().getPhoto().length != 0) {
            photoByte = userInstance.profile.photo
        } else {
            def fileName = System.getProperty("user.dir") + "/web-app/images/defaultUserPhoto/defaultUserPhoto.jpg"
            def file = new File(fileName)
            photoByte = new FileInputStream(file).bytes
        }
        response.setContentLength(photoByte.length)
        response.outputStream << photoByte
        response.outputStream.close()
    }


    def resetPassword() {
        def userInstance = User.get(params.get("id"))
        userInstance.setPasswordHash(new Sha256Hash(userInstance.getUsername()).toHex())
        if (userInstance.save(flush: true)) {
            flash.message = "重置密码成功"
        } else {
            flash.message = "重置密码失败"
        }

        redirect(action: "list")
    }
}
