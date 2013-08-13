<%@ page import="com.sanwn.mousika.UrlResource" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="course">
        <mousika:editor/>
        <title><g:message code="urlResource.create.label"/></title>
    </head>

    <body>
        <div id="create-url" class="content scaffold-create" role="main">
            <h4 class="content-top">
                <a href="${createLink(controller: 'course', action: 'show', id: params.courseId)}">${course.title}</a>->
            <g:message code="urlResource.create.label"/>
            </h4>
            <g:if test="${flash.message}">
                <div class="message" role="status"
                     style="color: red;">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${urlResource}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${urlResource}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form action="save" class="form-horizontal">
                <fieldset class="form">
                    <f:with bean="urlResource">
                        <g:hiddenField name="courseId" id="courseId"
                                       value="${courseId}"/>
                        <g:hiddenField name="sectionSeq" id="sectionSeq"
                                       value="${sectionSeq}"/>
                        <f:field property="title" required="true"/>
                        <f:field property="description"/>
                        <f:field property="location"/>
                    </f:with>
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton id="createUrlBtn" name="create"
                                    class="btn btn-primary"
                                    value="${message(code: 'urlResource.button.create.label', default: 'Create')}"/>
                    <a class="btn"
                       href="${createLink(controller: 'course', action: 'show', id: courseId)}">${message(code: 'default.cancel.label')}</a>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
