<%@ page import="com.sanwn.mousika.Label" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="user">
        <title><g:message code="user.show.label"/></title>
    </head>

    <body>
        <div id="show-user" class="content scaffold-show" role="main">
            <h4 style="text-align: center;">${userInstance.fullname}</h4>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <div class="well">
                <p><span style="font: bolder;">电子邮件：</span>${userInstance.email}</p>

                <p>上次访问时间：${userInstance.lastAccessed ?: 'N/A'}</p>
            </div>
            <g:link controller="message" action="create">发送消息</g:link>
        </div>
    </body>
</html>
