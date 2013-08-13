<%@ page import="com.sanwn.mousika.Label" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="course">
        <mousika:editor query="[courseId: course.id]"/>
        <title>编辑标签</title>
    </head>

    <body>
        <div id="edit-label" class="content scaffold-edit" role="main">
            <ul class="breadcrumb" style="margin-top: 20px;">
                <li>
                    <a href="${createLink(controller: 'course', action: 'show', id: params.courseId)}">
                        ${course.title}
                        <span class="divider">/</span>
                    </a>
                </li>
                <li>
                    <a href="${createLink(controller: 'courseUnit', action: 'show', id: params.unitId)}">
                        ${unit.title}
                        <span class="divider">/</span>
                    </a>
                </li>
                <li class="active">
                    编辑标签
                </li>
            </ul>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${labelInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${labelInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form method="post" action="update">
                <fieldset class="form">
                    <f:with bean="labelInstance">
                        <g:hiddenField name="courseId" value="${course.id}"/>
                        <g:hiddenField name="id" value="${labelInstance?.id}"/>
                        <g:hiddenField name="version"
                                       value="${labelInstance?.version}"/>
                        <f:field property="labelContent" required="true"/>
                    </f:with>
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton name="create" class="btn btn-primary"
                                    value="${message(code: 'default.button.update.label', default: 'Create')}"/>
                    <a class="btn"
                       href="${createLink(controller: 'course', action: 'show', id: course.id)}">${message(code: 'default.cancel.label')}</a>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
