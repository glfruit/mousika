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

    static url = "auth/login"

    static at = {
        title ==~ /.*登录$/
    }

    static content = {
        loginForm { $("form.navbar-form") }
        loginButton(to: ListPage) {
            loginForm.login()
        }
    }

    def login(String username, String password) {
        loginForm.with {
            username = username
            password = password
        }
        loginForm.click()
    }
}
