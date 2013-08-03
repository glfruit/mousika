<%@ page import="com.sanwn.mousika.Course" %>
<!DOCTYPE html>
<html>
    <head>
        <title><g:message code="course.grade.label"/></title>
    </head>

    <body>
        <div id="course-grade-book" class="content scaffold-create" role="main">
            <h4 class="text-center">
                ${course.title}-<g:message
                    code="course.grade.label"/></h4>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>序号</th>
                        <th>作业</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${assignments}" var="assignment" status="i">
                        <tr>
                            <td>${i + 1}</td>
                            <td>
                                <a href="${createLink(controller: 'gradeBook', action: 'show', id: course.id, params: [assignmentItemId: assignment.id])}">
                                    ${assignment.title}
                                </a>
                            </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
            <g:paginate total="total" action="grade" id="${params.id}"
                        prev="&lt;" max="20"
                        next="&gt;"></g:paginate>
        </div>
    </body>
</html>