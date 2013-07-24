package com.sanwn.mousika



import org.junit.*
import grails.test.mixin.*

@TestFor(FileRepositoryController)
@Mock(FileRepository)
class FileRepositoryControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/fileRepository/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.fileRepositoryInstanceList.size() == 0
        assert model.fileRepositoryInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.fileRepositoryInstance != null
    }

    void testSave() {
        controller.save()

        assert model.fileRepositoryInstance != null
        assert view == '/fileRepository/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/fileRepository/show/1'
        assert controller.flash.message != null
        assert FileRepository.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/fileRepository/list'

        populateValidParams(params)
        def fileRepository = new FileRepository(params)

        assert fileRepository.save() != null

        params.id = fileRepository.id

        def model = controller.show()

        assert model.fileRepositoryInstance == fileRepository
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/fileRepository/list'

        populateValidParams(params)
        def fileRepository = new FileRepository(params)

        assert fileRepository.save() != null

        params.id = fileRepository.id

        def model = controller.edit()

        assert model.fileRepositoryInstance == fileRepository
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/fileRepository/list'

        response.reset()

        populateValidParams(params)
        def fileRepository = new FileRepository(params)

        assert fileRepository.save() != null

        // test invalid parameters in update
        params.id = fileRepository.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/fileRepository/edit"
        assert model.fileRepositoryInstance != null

        fileRepository.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/fileRepository/show/$fileRepository.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        fileRepository.clearErrors()

        populateValidParams(params)
        params.id = fileRepository.id
        params.version = -1
        controller.update()

        assert view == "/fileRepository/edit"
        assert model.fileRepositoryInstance != null
        assert model.fileRepositoryInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/fileRepository/list'

        response.reset()

        populateValidParams(params)
        def fileRepository = new FileRepository(params)

        assert fileRepository.save() != null
        assert FileRepository.count() == 1

        params.id = fileRepository.id

        controller.delete()

        assert FileRepository.count() == 0
        assert FileRepository.get(fileRepository.id) == null
        assert response.redirectedUrl == '/fileRepository/list'
    }
}
