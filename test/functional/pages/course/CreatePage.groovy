package pages.course

import geb.Page

class CreatePage extends Page {
    static url = "course/create"

    static at = {
        title ==~ /创建课程/
    }

    static content = {
        createForm { $("form", 0) }
        createButton(to: EnrolPage) { $("#create-course-button") }
    }

    def addCourse(course) {
        createForm.code = course[0]
        createForm.title = course[1]
        createForm.startDate = course[2]
        createForm.numberOfWeeks = course[3].trim().toInteger()
        createButton.click()
    }
}