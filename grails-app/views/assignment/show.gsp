<%@ page import="com.sanwn.mousika.Assignment" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="course">
        <mousika:editor/>
        <title><g:message code="assignment.pageTitle"/></title>
    </head>

    <body>
        <div id="show-assignment" class="content scaffold-create" role="main">
            <ul class="breadcrumb" style="margin-top: 30px;">
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
            <h3 style="text-align: center;">${assignment?.title}</h3>
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
            <div style="border: 1px solid #EEEEFF;">
                <%=assignment?.description%>
            </div>
            <shiro:hasRole name="教师">
                <h4>作业提交情况</h4>
                <table class="table">
                    <thead>
                        <th>总人数</th>
                        <th>已交人数</th>
                    </thead>
                    <tbody>
                        <td>40</td>
                        <td>8</td>
                    </tbody>
                </table>
            </shiro:hasRole>
            <shiro:hasRole name="学生">
                <hr/>
                <g:form action="createAttempt">
                    <g:hiddenField name="assignmentId"
                                   value="${assignment.id}"/>
                    <label>回答</label>

                    <p><g:textArea name="attemptContent"
                                   value="${attempt?.attemptContent}"
                                   rows="10"/></p>
                    <button type="submit" class="btn btn-primary">提交</button>
                </g:form>
            </shiro:hasRole>
        </div>
    </body>
</html>
