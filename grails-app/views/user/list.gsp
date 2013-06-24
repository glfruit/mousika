<%@ page import="com.sanwn.mousika.Label" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="user">
        <title><g:message code="user.list.label"/></title>
    </head>

    <body>
        <div id="list-user" class="content scaffold-show" role="main">
            <h4 style="text-align: center;"><g:message
                    code="user.list.label"/></h4>
            <g:link action="create" class="btn pull-right">批量添加用户</g:link>
            <g:link action="create" class="btn pull-right">添加用户</g:link>
            <table class="table">
                <thead>
                    <tr>
                        <th>用户名</th>
                        <th>姓名</th>
                        <th>电子邮件</th>
                        <th>首次访问时间</th>
                        <th>最后访问时间</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${userInstanceList}" var="user">
                        <tr>
                            <td>${user.username}</td>
                            <td>${user.fullname}</td>
                            <td>${user.profile?.email}</td>
                            <td><g:formatDate format="yyyy-MM-dd HH:mm:ss"
                                              date="${user.profile?.firstAccessed}"/></td>
                            <td><g:formatDate format="yyyy-MM-dd HH:mm:ss"
                                              date="${user.profile?.lastAccessed}"/></td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </div>
    </body>
</html>
