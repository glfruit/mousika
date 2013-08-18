
<%@ page import="com.sanwn.mousika.User" %>
<!DOCTYPE html>
<html>
<head>
    <shiro:hasRole name="学生">
        <meta name="layout" content="student">
    </shiro:hasRole>
    <shiro:hasAnyRole in="['教师', '系统管理员','课程负责人']">
        <meta name="layout" content="system">
    </shiro:hasAnyRole>
    <title><g:message code="user.upload.photo"/></title>
    <style type="text/css">
    ul{list-style:none;}
    li{list-style:none;}
    </style>
</head>
<body>
<div id="updateInformation-user" class="content scaffold-list" role="system">
    <h4 style="border-bottom: 1px solid black;">上传头像</h4>
    <g:if test="${flash.message}">
        <div class="message" role="error">${flash.message}</div>
    </g:if>
    <img src="${createLink(controller: 'user', action: 'displayPhoto')}" width="100" height="100"/>
    <div class="container">
        <g:uploadForm action="uploadPhoto">
            <input type="file" name="photo" />
            <input type="submit" value="上传"/> 　(请选择jpeg、bmp、png或gif格式并且小于200KB的图片上传)
        </g:uploadForm>
    </div>
</div>
</body>
</html>