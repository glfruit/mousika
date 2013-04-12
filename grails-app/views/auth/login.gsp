<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="dojo"/>
        <title>Login</title>
    </head>

    <body>
        <h4 style="border-bottom: 1px solid #000;color: #777777;"><g:message
                code="label.course.list"/></h4>

        <p>暂时没有任何课程</p>
        <shiro:authenticated>
            <g:link controller="course" action="create"
                    class="btn">创建新课程</g:link>
        </shiro:authenticated>
    </body>
</html>
