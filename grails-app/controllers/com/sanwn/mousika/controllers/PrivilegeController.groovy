package com.sanwn.mousika.controllers

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
    }
}
