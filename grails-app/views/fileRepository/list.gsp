<%@ page import="com.sanwn.mousika.FileRepository" %>
<%@ taglib uri="http://ckfinder.com" prefix="ckfinder" %>
<!DOCTYPE html>
<html>
    <head>
        <shiro:hasRole name="学生">
            <meta name="layout" content="student">
        </shiro:hasRole>
        <shiro:hasAnyRole in="['教师', '系统管理员','课程负责人']">
            <meta name="layout" content="course">
        </shiro:hasAnyRole>

        <title>我的个人文件</title>
    </head>

    <body>
        <div id="list-fileRepository" class="content scaffold-list" role="main">
            <h4 style="border-bottom: 1px solid black;">
                <g:if test="${session[FileRepository.REPOSITORY_TYPE] == FileRepository.REPOSITORY_TYPE_COURSE}">
                    <a href="${createLink(controller: 'course', action: 'show', id: course?.id)}">${course?.title}</a>->课程资料
                </g:if>
                <g:else>
                    我的个人文件
                </g:else>
            </h4>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <ckfinder:ckfinder basePath="${resource(dir: '/ckfinder')}"/>
        </div>
    </body>
</html>
