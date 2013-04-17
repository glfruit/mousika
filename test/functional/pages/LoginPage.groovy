package pages

import geb.Page
import pages.course.ListPage

/**
 *
 * @author glix
 * @version 1.0
 *
 */
class LoginPage extends Page {

    static url = "/mousika/"

    static at = {
        title ==~ /.*登录$/
    }

    static content = {
        loginForm { $("form.navbar-form") }
        loginButton(to: ListPage) {
            $("button.login")
        }
    }

    def login(String username, String password) {
        loginForm.username = username
        loginForm.password = password
        loginButton.click()
    }
}
