package com.sanwn.mousika.domain

import grails.test.mixin.TestFor

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Course)
class CourseTests {

    void testCourseTitle() {
        mockForConstraintsTests Course
        def course = new Course(title: 'Computer', code: '102939')
        assert !course.validate()

        assert 'nullable' == course.errors['author']
    }

    void testStartDateNotEarlyThanCurrent() {
        mockForConstraintsTests Course
        def course = new Course(title: 'Computer', code: '19223', author:  'author', startDate: (new Date()) - 1)
        assert !course.validate()
        assert 'min' == course.errors['startDate']
    }
}
