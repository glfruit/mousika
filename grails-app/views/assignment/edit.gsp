<%@ page import="com.sanwn.mousika.Assignment" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="course">
        <mousika:editor query="[courseId: course.id]"/>
        <title><g:message code="assignment.edit.label"/></title>
    </head>

    <body>
        <div id="edit-assignment" class="content scaffold-create" role="main">
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
                    ${assignment.title}
                </li>
            </ul>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${assignment}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${assignment}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form action="update" class="form-horizontal">
                <fieldset class="form">
                    <f:with bean="assignment">
                        <g:hiddenField name="courseId" id="courseId"
                                       value="${course.id}"/>
                        <g:hiddenField name="id" value="${assignment.id}"/>
                        <g:hiddenField name="unitId" value="${params.unitId}"/>
                        <g:hiddenField name="version"
                                       value="${assignment.version}"/>
                        <f:field property="title" required="true"/>
                        <f:field property="description" required="true"/>
                        <f:field property="style" required="true"/>
                        <f:field property="availableFrom"/>
                        <f:field property="dueDate"/>
                        <f:field property="lateSubmitAllowed"/>
                    </f:with>
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton name="create" class="btn btn-primary"
                                    value="${message(code: 'default.button.update.label', default: 'Create')}"/>
                    <a class="btn"
                       href="${createLink(controller: 'course', action: 'show', id: course.id)}">${message(code: 'default.cancel.label')}</a>
                </fieldset>
            </g:form>
            <script>
                require(['dojo/query', 'dojo/dom-attr'], function (query, domAttr) {
                    query('#createAndShowBtn').on('click', function () {
                        domAttr.set(query('#returnToCourse')[0], 'value', 'false');
                    });
                    query('#createAndReturnBtn').on('click', function () {
                        domAttr.set(query('#returnToCourse')[0], 'value', 'true');
                    });
                });
            </script>
        </div>
        <script>
            require(['dojo/query', 'bootstrap/Datepicker'], function (query) {
                query(".date").datepicker({
                    format: 'yyyy-mm-dd',
                    weekStart: 1
                });
            });
        </script>
    </body>
</html>
