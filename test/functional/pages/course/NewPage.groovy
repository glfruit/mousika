package pages.course

import data.Data
import geb.Page

/**
 *
 * @author glix
 * @version 1.0
 *
 */
class NewPage extends Page {

    static at = {
        title ==~ /Create Course/
    }

    static content = {
        save {
            $('input.save')
        }
    }

    def add(String courseTitle) {
        def course = Data.findByTitle(courseTitle)

        if (course.title == courseTitle) {
            $("form").author = course.author
        }
        $("form").title = courseTitle

        save.click()
    }
}
