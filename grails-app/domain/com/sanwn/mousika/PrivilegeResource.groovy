package com.sanwn.mousika

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-8-5
 * Time: 下午7:48
 * To change this template use File | Settings | File Templates.
 */
class PrivilegeResource {

    String controllerEn

    String controllerCn

     static hasMany = [privilegeResourceMethods: PrivilegeResourceMethod]

    static constraints = {
        controllerEn blank: false
        controllerCn blank: false,unique:true
    }

    static mapping = {
        table 'privilege_resource'
    }
}

