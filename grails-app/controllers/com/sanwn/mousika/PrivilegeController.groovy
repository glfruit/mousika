package com.sanwn.mousika

import com.sanwn.mousika.*
import org.apache.shiro.SecurityUtils
import org.springframework.dao.DataIntegrityViolationException

class PrivilegeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def gsonBuilder

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        def role = Role.findByName("系统管理员")
        def privilegeResourceInstanceList = PrivilegeResource.getAll();
        [privilegeResourceInstanceList: privilegeResourceInstanceList, role: role, permissions:role.permissions]
        /*withFormat {
            html {
                [privilegeResourceInstanceList: privilegeResourceInstanceList, role: role]
            }
            json {
                def json = PrivilegeResource.getAll().collect {
                    [
                            id: it.id,
                            controllerEn: it.controllerEn,
                            controllerCn: it.controllerCn,
                            privilegeResourceMethods: it.privilegeResourceMethods.collect {
                                [
                                        id: it.id,
                                        methodEn: it.methodEn,
                                        methodCn: it.methodCn
                                ]
                            }
                    ]
                }
                def gson = gsonBuilder.create()
                render contentType: "text/json", text: gson.toJson(json)
            }
        }*/
    }

    def create() {
        redirect(action: "list", params: params)
    }

    def save() {
        def roleInstance = Role.get(params.long('role'))

        def permissionsMap = new HashMap<String,String>()

        def controller
        def method
        def key
        def value
        Set<String> paramsSet = params.keySet()
        for (Iterator it = paramsSet.iterator(); it.hasNext();) {
            key = (String) it.next()
            if (key.contains(":")){
                controller = key.split(":")[0] ;
                method = key.split(":")[1];
                if (permissionsMap.containsKey(controller)) {
                    value =  permissionsMap.get(controller);
                    permissionsMap.put(controller,value+","+method)
                }else{
                    permissionsMap.put(controller,controller+":"+method)
                }
            }
        }

        def permissionsSet = permissionsMap.keySet();
        roleInstance.permissions.clear()
        for (Iterator it = permissionsSet.iterator(); it.hasNext();) {
            roleInstance.permissions.add(permissionsMap.get(it.next()))
        }

        roleInstance.save(failOnError: true)
        flash.message = "保存角色权限成功"

        redirect(action: "list", params: params)
    }

    def getRolePermission() {
        def role = Role.get(params.long('role'))
        render "${role.permissions}"
    }
}
