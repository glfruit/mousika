package com.sanwn.mousika.controllers

import com.sanwn.mousika.*
import org.apache.shiro.SecurityUtils
import org.springframework.dao.DataIntegrityViolationException

class PrivilegeController {



    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        def role = Role.get(1L)
        def privilegeResourceInstanceList = PrivilegeResource.getAll();
        [privilegeResourceInstanceList:privilegeResourceInstanceList, permissions:role.permissions, role:role]
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
        redirect(action: "list", params: params)
    }

    def getRolePermission() {
        def role = Role.get(params.long('role'))
        render "${role.permissions}"
    }
}
