package data

/**
 *
 * @author glix
 * @version 1.0
 *
 */
class Data {

    static def courses = [
            [title: "Computer Networks", author: "Gojko Adzic"]
    ]

    static public def findByTitle(String title) {
        courses.find { course ->
            course.title == title
        }
    }
}
