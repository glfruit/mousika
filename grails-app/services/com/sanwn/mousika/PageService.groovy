package com.sanwn.mousika

class PageException extends RuntimeException {

    String message

    Page page
}

class PageService {

    static transactional = true

    def createPage(Page page) {
        if (page.validate() && page.save()) {
            return page
        }
        throw new PageException(message: "创建页面内容错误", page: page)
    }
}
