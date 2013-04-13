package pages.course

import geb.Page

class CreatePage extends Page {
    static url = "course/create"

    static at = {
        title ==~ /创建课程/
    }

    static content = {
    }
}