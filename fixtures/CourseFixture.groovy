import com.sanwn.mousika.domain.Course
import com.sanwn.mousika.domain.CourseMember
import com.sanwn.mousika.domain.CourseSection

include 'UserFixture'

build {
    member(CourseMember, user: user, role: role)
    course(Course, courseMembers: [member])
    section(CourseSection, course: course)
}

