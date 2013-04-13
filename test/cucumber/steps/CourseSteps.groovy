import pages.LoginPage
import pages.course.CreatePage

import static cucumber.api.groovy.EN.*

Given(~'I login with valid username and password$') {->
    to LoginPage
    at LoginPage
    page.login()
}

And(~'^I open the create course page$') {->
    to CreatePage
    at CreatePage
}

When(~'^I add "([^"]*)"$') { String courseTitle ->
    assert false
}

Then(~'^I see enroll member page$') {->
    assert false
}