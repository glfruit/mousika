package com.sanwn.mousika



import org.junit.*
import grails.test.mixin.*

@TestFor(UrlResourceController)
@Mock(UrlResource)
class UrlResourceControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/urlResource/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.urlResourceInstanceList.size() == 0
        assert model.urlResourceInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.urlResourceInstance != null
    }

    void testSave() {
        controller.save()

        assert model.urlResourceInstance != null
        assert view == '/urlResource/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/urlResource/show/1'
        assert controller.flash.message != null
        assert UrlResource.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/urlResource/list'

        populateValidParams(params)
        def urlResource = new UrlResource(params)

        assert urlResource.save() != null

        params.id = urlResource.id

        def model = controller.show()

        assert model.urlResourceInstance == urlResource
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/urlResource/list'

        populateValidParams(params)
        def urlResource = new UrlResource(params)

        assert urlResource.save() != null

        params.id = urlResource.id

        def model = controller.edit()

        assert model.urlResourceInstance == urlResource
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/urlResource/list'

        response.reset()

        populateValidParams(params)
        def urlResource = new UrlResource(params)

        assert urlResource.save() != null

        // test invalid parameters in update
        params.id = urlResource.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/urlResource/edit"
        assert model.urlResourceInstance != null

        urlResource.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/urlResource/show/$urlResource.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        urlResource.clearErrors()

        populateValidParams(params)
        params.id = urlResource.id
        params.version = -1
        controller.update()

        assert view == "/urlResource/edit"
        assert model.urlResourceInstance != null
        assert model.urlResourceInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/urlResource/list'

        response.reset()

        populateValidParams(params)
        def urlResource = new UrlResource(params)

        assert urlResource.save() != null
        assert UrlResource.count() == 1

        params.id = urlResource.id

        controller.delete()

        assert UrlResource.count() == 0
        assert UrlResource.get(urlResource.id) == null
        assert response.redirectedUrl == '/urlResource/list'
    }
}
