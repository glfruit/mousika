<%@ page import="com.sanwn.mousika.Course" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet"
              href="${resource(dir: 'css', file: 'datepicker.css')}"
              type="text/css"/>
        <title>导入课程</title>
    </head>

    <body>
        <div id="copy-course" class="content scaffold-create" role="main">
            <h3 class="text-center"><g:message
                    code="default.course.copy.label"/></h3>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${copied}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${copied}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form id="create-course-form" action="saveCopy"
                    class="form-horizontal">
                <g:hiddenField name="courseId" value="${courseId}"/>
                <f:with bean="copied">
                    <f:field property="courseToken"/>
                    <f:field property="startDate"/>
                    <f:field property="available"/>
                    <f:field property="guestVisible"/>
                </f:with>
                <div class="control-group pagination-centered">
                    <g:submitButton id="copy-course-button" name="copy"
                                    class="btn btn-primary"
                                    value="${message(code: 'default.button.copy.label', default: 'copy')}"/>
                    <a class="btn" href="${createLink(action: 'list')}">取消</a>
                </div>
            </g:form>
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
