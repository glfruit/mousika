<!DOCTYPE html>
<html>
    <head>
        <shiro:hasRole name="学生">
            <meta name="layout" content="student">
        </shiro:hasRole>
        <shiro:hasAnyRole in="['教师', '系统管理员','课程负责人']">
            <meta name="layout" content="course">
        </shiro:hasAnyRole>
        <title>${pageInstance?.title}</title>
    </head>

    <body>
        <div id="show-page" class="content scaffold-show" role="main">
            <h4 class="content-top">
                <a href="${createLink(controller: 'course', action: 'show', id: course.id)}">${course.title}</a>-&gt;
                <a href="${createLink(controller: 'course', action: 'show', id: course.id, fragment: "courseSection${unit.sequence}")}">${unit.title}</a>-&gt;
                ${pageInstance?.title}</h4>
            <g:if test="${flash.message}">
                <div class="message text-success"
                     role="status">${flash.message}</div>
            </g:if>
            <h3>${pageInstance?.title}</h3>
            <%=pageInstance?.content%>
        </div>
    </body>
</html>
