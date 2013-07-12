import pages.LoginPage
import pages.course.ListPage

import static cucumber.api.groovy.EN.*

Given(~'^I open login page$') {->
    to LoginPage
    at LoginPage
}

When(~'^I input username "([^"]*)" and password "([^"]*)"$') { username, password ->
    page.login(username, password)
}

Then(~'^I see course list$') {->
    at ListPage
}