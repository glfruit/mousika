package com.sanwn.mousika

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-8-5
 * Time: 下午7:10
 * To change this template use File | Settings | File Templates.
 */
class PrivilegeResourceMethod {

    String methodEn

    String methodCn

    static constraints = {
        methodEn blank: false
        methodCn blank: false,unique:true
    }

    static belongsTo = PrivilegeResource

    static mapping = {
        table 'privilege_resource_method'
    }
}

