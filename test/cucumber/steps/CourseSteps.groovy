import pages.LoginPage
import pages.course.EnrolPage
import pages.course.ListPage

import static cucumber.api.groovy.EN.*

Given(~'^I login with valid username "([^"]*)" and password "([^"]*)"$') { username, password ->
    to LoginPage
    at LoginPage
    page.login(username, password)
    at ListPage
}

And(~'^I open the create course page$') {->
    page.toCreatePage()
}

When(~'^I add a course:$') { table ->
    page.addCourse(table.raw()[1])
}

Then(~'^I see enroll member page for "([^"]*)"$') { String courseTitle ->
    at EnrolPage
    page.courseTitle == courseTitle
}