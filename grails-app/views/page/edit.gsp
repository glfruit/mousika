<%@ page import="com.sanwn.mousika.Page" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="course">
        <mousika:editor query="[courseId: course.id]"/>
        <title><g:message code="page.edit.label"/></title>
    </head>

    <body>
        <div id="edit-page" class="content scaffold-create" role="main">
            <h4 style="padding-top: 20px;">
                <a href="${createLink(controller: 'course', action: 'show', id: params.courseId)}">${course.title}</a>->
                <g:message code="page.edit.label"/></h4>
            <g:if test="${flash.message}">
                <div class="message" role="status"
                     style="color: red;">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${pageInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${pageInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form action="update" class="form-horizontal">
                <fieldset class="form">
                    <f:with bean="pageInstance">
                        <g:hiddenField name="courseId" id="courseId"
                                       value="${course.id}"/>
                        <g:hiddenField name="unitId" id="unitId"
                                       value="${params.unitId}"/>
                        <g:hiddenField name="id" id="id"
                                       value="${pageInstance?.id}"/>
                        <g:hiddenField name="version"
                                       value="${pageInstance?.version}"/>
                        <f:field property="title" required="true"/>
                        <f:field property="description"/>
                        <f:field property="content"/>
                    </f:with>
                </fieldset>
                <fieldset class="buttons pull-right">
                    <g:submitButton id="updatePageBtn" name="updatePageBtn"
                                    class="btn btn-primary"
                                    value="${message(code: 'default.button.update.label')}"/>
                    <a class="btn"
                       href="${createLink(controller: 'course', action: 'show', id: course.id)}">${message(code: 'default.cancel.label')}</a>
                </fieldset>
            </g:form>
            <script>
                require(['dojo/query', 'dojo/dom-attr', 'jquery'], function (query, domAttr) {
                    query('#createAndShowBtn').on('click', function () {
                        domAttr.set(query('#returnToCourse')[0], 'value', 'false');
                    });
                    query('#createAndReturnBtn').on('click', function () {
                        domAttr.set(query('#returnToCourse')[0], 'value', 'true');
                    });
                });
            </script>
        </div>
    </body>
</html>
