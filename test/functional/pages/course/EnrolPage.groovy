package pages.course

import geb.Page

/**
 *
 * @author glix
 * @version 1.0
 *
 */
class EnrolPage extends Page {

    static url = "course/enrol"

    static at = {
        title ==~ "添加成员"
    }

    static content = {
        courseTitle { $("h4#courseTitleHead") }
    }
}
