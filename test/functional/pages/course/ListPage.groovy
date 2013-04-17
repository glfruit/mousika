package pages.course

import geb.Page

/**
 *
 * @author glix
 * @version 1.0
 *
 */
class ListPage extends Page {

    static url = "course/list"

    static at = {
        title ==~ "课程列表"
    }

    static content = {
        createLink(to: CreatePage) { $("a.create") }
    }

    def toCreatePage() {
        createLink.click()
    }
}
