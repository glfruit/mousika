import com.sanwn.mousika.Course
import com.sanwn.mousika.CourseMember
import com.sanwn.mousika.CourseSection
import com.sanwn.mousika.CourseUnit

include 'UserFixture'

build {
    member(CourseMember, user: user, role: role)
    course(Course, courseMembers: [member])
    section(CourseUnit, course: course)
}

