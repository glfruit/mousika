<!DOCTYPE html>
<html>
    <head>
    <shiro:hasRole name="学生">
        <meta name="layout" content="student">
    </shiro:hasRole>
    <shiro:hasAnyRole in="['教师', '系统管理员','课程负责人']">
        <meta name="layout" content="course">
    </shiro:hasAnyRole>
        <title>${notification?.title}</title>
    </head>

    <body>
        <div id="show-notification" class="content scaffold-show" role="main">
            <g:if test="${course}">
                <ul class="breadcrumb" style="margin-top: 20px;">
                    <li>
                        <a href="${createLink(controller: 'course', action: 'show', id: course.id)}">${course.title}</a>
                        <span class="divider">/</span>
                    </li>
                    <li>
                        <a href="${createLink(controller: 'notification', action: 'list', params: [courseId: course.id])}">课程通知</a>
                        <span class="divider">/</span>
                    </li>
                    <li class="active">
                        ${notification.title}
                    </li>
                </ul>
            </g:if>
            <g:else>
                <h3 style="text-align: center; max-resolution: 20px;">公共通知</h3>
            </g:else>

            <h4 style="text-align: center;">${notification?.title}</h4>
            <%=notification?.content%>
        </div>
    </body>
</html>
