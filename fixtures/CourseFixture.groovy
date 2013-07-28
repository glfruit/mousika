import com.sanwn.mousika.*

include 'UserFixture'

build {
    member(CourseMember, user: user, role: role)
    course(Course, courseMembers: [member])
    section(CourseUnit, course: course, sequence: 0)
    targetUnit(CourseUnit, course: course, sequence: 1)
    lastUnit(CourseUnit, course: course, sequence: 2)
    page0(Page)
    page1(Page)
    page2(Page)
    item0(UnitItem, unit: section, sequence: 0,content:page0)
    item1(UnitItem, unit: section, sequence: 1, content: page1)
    item2(UnitItem, unit: section, sequence: 2, content: page2)
    page00(Page)
    page11(Page)
    page22(Page)
    page33(Page)
    item00(UnitItem, unit: targetUnit, sequence: 0,content:page00)
    item11(UnitItem, unit: targetUnit, sequence: 1, content: page11)
    item22(UnitItem, unit: targetUnit, sequence: 2, content: page22)
    item33(UnitItem, unit: targetUnit, sequence: 3, content: page33)
}

