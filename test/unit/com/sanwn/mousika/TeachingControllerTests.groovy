package com.sanwn.mousika



import org.junit.*
import grails.test.mixin.*

@TestFor(TeachingController)
@Mock(Teaching)
class TeachingControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/teaching/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.teachingInstanceList.size() == 0
        assert model.teachingInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.teachingInstance != null
    }

    void testSave() {
        controller.save()

        assert model.teachingInstance != null
        assert view == '/teaching/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/teaching/show/1'
        assert controller.flash.message != null
        assert Teaching.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/teaching/list'

        populateValidParams(params)
        def teaching = new Teaching(params)

        assert teaching.save() != null

        params.id = teaching.id

        def model = controller.show()

        assert model.teachingInstance == teaching
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/teaching/list'

        populateValidParams(params)
        def teaching = new Teaching(params)

        assert teaching.save() != null

        params.id = teaching.id

        def model = controller.edit()

        assert model.teachingInstance == teaching
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/teaching/list'

        response.reset()

        populateValidParams(params)
        def teaching = new Teaching(params)

        assert teaching.save() != null

        // test invalid parameters in update
        params.id = teaching.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/teaching/edit"
        assert model.teachingInstance != null

        teaching.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/teaching/show/$teaching.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        teaching.clearErrors()

        populateValidParams(params)
        params.id = teaching.id
        params.version = -1
        controller.update()

        assert view == "/teaching/edit"
        assert model.teachingInstance != null
        assert model.teachingInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/teaching/list'

        response.reset()

        populateValidParams(params)
        def teaching = new Teaching(params)

        assert teaching.save() != null
        assert Teaching.count() == 1

        params.id = teaching.id

        controller.delete()

        assert Teaching.count() == 0
        assert Teaching.get(teaching.id) == null
        assert response.redirectedUrl == '/teaching/list'
    }
}
