<%@ page import="com.sanwn.mousika.Assignment" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="course">
        <mousika:editor query="[courseId:course.id]"/>
        <title><g:message code="assignment.create.label"/></title>
    </head>

    <body>
        <div id="create-assignment" class="content scaffold-create" role="main">
            <h4 style="padding-top: 20px;">
                <a href="${createLink(controller: 'course', action: 'show', id: params.courseId)}">${course.title}</a>->
            <g:message code="assignment.create.label"/>
            </h4>
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
            <g:form action="save" class="form-horizontal">
                <fieldset class="form">
                    <f:with bean="assignment">
                        <g:hiddenField name="courseId" id="courseId"
                                       value="${courseId}"/>
                        <g:hiddenField name="sectionSeq" id="sectionSeq"
                                       value="${sectionSeq}"/>
                        <g:hiddenField name="returnToCourse" id="returnToCourse"
                                       value="false"/>
                        <f:field property="title" required="true"/>
                        <f:field property="description" required="true"/>
                        <f:field property="style" required="true"/>
                        <f:field property="availableFrom"/>
                        <f:field property="dueDate"/>
                        <f:field property="lateSubmitAllowed"/>
                    </f:with>
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton id="createAndShowBtn" name="create"
                                    class="btn"
                                    value="${message(code: 'button.assignment.create.label', default: 'Create')}"/>
                    <g:submitButton id="createAndReturnBtn"
                                    name="createAndReturn" class="btn"
                                    value="创建并返回到课程"/>
                    <a class="btn"
                       href="${createLink(controller: 'course', action: 'show', id: courseId)}">${message(code: 'default.cancel.label')}</a>
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
