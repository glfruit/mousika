<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="course">
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
