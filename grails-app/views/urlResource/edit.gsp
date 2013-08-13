<%@ page import="com.sanwn.mousika.UrlResource" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="course">
        <mousika:editor query="[courseId: course.id]"/>
        <title><g:message code="urlResource.edit.label"/></title>
    </head>

    <body>
        <div id="edit-url" class="content scaffold-create" role="main">
            <h4 class="content-top">
                <a href="${createLink(controller: 'course', action: 'show', id: params.courseId)}">${course.title}</a>->
            <g:message code="urlResource.edit.label"/>
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
            <g:form action="update" class="form-horizontal">
                <fieldset class="form">
                    <f:with bean="urlResource">
                        <g:hiddenField name="courseId" id="courseId"
                                       value="${course.id}"/>
                        <g:hiddenField name="id" value="${urlResource.id}"/>
                        <f:field property="title" required="true"/>
                        <f:field property="description"/>
                        <f:field property="location"/>
                    </f:with>
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton id="updateUrlBtn" name="updateUrlBtn"
                                    class="btn btn-primary"
                                    value="${message(code: 'default.button.update.label', default: 'Update')}"/>
                    <a class="btn"
                       href="${createLink(controller: 'course', action: 'show', id: course.id)}">${message(code: 'default.cancel.label')}</a>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
