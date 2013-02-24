package pages.course

import data.Data
import geb.Page

/**
 *
 * @author glix
 * @version 1.0
 *
 */
class ShowPage extends Page {

    static at = {
        title ==~ /Show Course/
    }

    static content = {
        row { val ->
            $('span.property-label', text: val).parent()
        }

        value { val ->
            row(val).find('span.property-value').text()
        }

        id {
            value('id')
        }

        ctitle {
            value('Title')
        }

        author {
            value('Author')
        }
    }

    def check(String title) {
        def course = Data.findByTitle(title)
        assert course.author == author
        assert course.title == ctitle
    }
}
