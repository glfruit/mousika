<%@ page import="com.sanwn.mousika.FileResource" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="course">
        <g:set var="entityName"
               value="${message(code: 'fileResource.label', default: 'FileResource')}"/>
        <title><g:message code="default.create.label"
                          args="[entityName]"/></title>
        <ckeditor:resources/>
    </head>

    <body>
        <div id="create-fileResource" class="content scaffold-create"
             role="main">
            <h4>创建文件资源</h4>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${fileResourceInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${fileResourceInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <ckeditor:editor name="myeditor" height="400px" width="80%" filebrowserBrowseUrl="${request.contextPath}/ckfinder/ckfinder.html"
                             filebrowserImageBrowseUrl="${request.contextPath}/ckfinder/ckfinder.html?Type=Images"
                             filebrowserUploadUrl="${request.contextPath}/ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Files"
                             filebrowserImageUploadUrl="${request.contextPath}/ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Images">
                This is text editor.
            </ckeditor:editor>
            <g:form action="save">
                <g:render template="/uploader"/>
                <fieldset class="form">
                    <g:hiddenField name="sectionSeq" value="${sectionSeq}"/>
                    <g:render template="form"/>
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton name="create" class="save"
                                    value="${message(code: 'default.button.create.label', default: 'Create')}"/>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
