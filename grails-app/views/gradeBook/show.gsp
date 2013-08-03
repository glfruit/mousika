<html>
    <head>
        <meta name="layout" content="course"/>
        <title>作业成绩</title>
        <style>
        li {
            cursor: text;
        }
        </style>
    </head>

    <body>
        <h4 style="border-bottom: 1px solid #000;color: #777777;">
            《${course.title}》作业：“${assignmentItem.title}"成绩表
        </h4>
        <g:if test="${flash.message}">
            <div class="text-success" role="status">${flash.message}</div>
        </g:if>
        <table class="table table-striped">
            <thead>
                <tr>
                    <td>序号</td>
                    <td>学生</td>
                    <td>成绩</td>
                    <td>提交时间</td>
                </tr>
            </thead>
            <tbody>
                <g:each in="${attempts}" var="attempt" status="i">
                    <tr>
                        <td>${i + 1}</td>
                        <td>
                            <a href="${createLink(action: 'evaluate', id: course.id, params: [attemptId: attempt.id, assignmentItemId: assignmentItem.id])}">
                                ${attempt.submittedBy.fullname}</a>
                        </td>
                        <td><input type="text" size="4"
                                   value="${attempt.score}"/></td>
                        <td><g:formatDate
                                date="${attempt.submittedDate}"
                                format="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                </g:each>
            </tbody>
        </table>
    </body>
</html>
