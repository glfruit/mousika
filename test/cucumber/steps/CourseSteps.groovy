import pages.course.ListPage
import pages.course.NewPage
import pages.course.ShowPage

import static cucumber.api.groovy.EN.*

Given(~'^I choose to create a new course$') {->
    to ListPage
    at ListPage
}
When(~'^I add "([^"]*)"$') { String title ->
    page.toNewPage()
    at NewPage
    page.add(title)
}
Then(~'^I see a new course page for "([^"]*)"$') { String title ->
    at ShowPage
    page.check(title)
}