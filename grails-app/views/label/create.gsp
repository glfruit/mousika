<%@ page import="com.sanwn.mousika.Label" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="course">
        <mousika:editor/>
        <title><g:message code="label.create.label"/></title>
    </head>

    <body>
        <div id="create-label" class="content scaffold-create" role="main">
            <h3><g:message code="label.create.label"/></h3>
            <g:if test="${flash.message}">
                <div class="message" role="status"
                     style="color: red;">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${labelInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${labelInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form action="save" class="form-horizontal">
                <fieldset class="form">
                    <f:with bean="labelInstance">
                        <g:hiddenField name="courseId" id="courseId"
                                       value="${courseId}"/>
                        <g:hiddenField name="sectionSeq" id="sectionSeq"
                                       value="${sectionSeq}"/>
                        <f:field property="labelContent" required="true"/>
                    </f:with>
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton id="createLabelBtn" name="create"
                                    class="btn btn-primary"
                                    value="${message(code: 'label.button.create.label', default: 'Create')}"/>
                    <a class="btn"
                       href="${createLink(controller: 'course', action: 'show', id: courseId)}">${message(code: 'default.cancel.label')}</a>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
