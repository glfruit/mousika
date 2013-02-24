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
        title ==~ /Course List/
    }

    static content = {
        create(to: NewPage) {
            $('a.create')
        }
    }

    def toNewPage() {
        create.click()
    }
}
