<%@ page import="com.sanwn.mousika.FileResource" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="course">
        <mousika:editor query="[courseId: params.courseId]"/>
        <title><g:message code="fileResource.button.create.label"/></title>
    </head>

    <body>
        <div id="create-fileResource" class="content scaffold-create"
             role="main">
            <h4 class="content-top">
                <a href="${createLink(controller: 'course', action: 'show', id: params.courseId)}">${course.title}</a>->
            <g:message code="fileResource.button.edit.label"/>
            </h4>
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
            <g:uploadForm action="update" class="form-horizontal">
                <fieldset class="form">
                    <f:with bean="fileResourceInstance">
                        <g:hiddenField name="courseId" value="${course?.id}"/>
                        <g:hiddenField name="id"
                                       value="${fileResourceInstance?.id}"/>
                        <g:hiddenField name="version"
                                       value="${fileResourceInstance?.version}"/>
                        <f:field property="title" required="true"/>
                        <f:field property="description"/>
                    </f:with>
                    文件：<a
                        href="${createLink(controller: 'fileResource', action: 'show',
                                id: fileResourceInstance?.id)}">${fileResourceInstance.title + '.' + fileResourceInstance.fileType}</a>
                    <input type="file" name="qqfile"/>
                </fieldset>
                <fieldset class="buttons">
                    %{--<g:render template="/uploader"/>--}%
                    <g:submitButton name="create" class="btn btn-primary"
                                    value="${message(code: 'default.button.update.label', default: 'Create')}"/>
                    <a class="btn"
                       href="${createLink(controller: 'course', action: 'show', id: courseId)}">${message(code: 'default.cancel.label')}</a>
                </fieldset>
            </g:uploadForm>
        </div>
    </body>
</html>
