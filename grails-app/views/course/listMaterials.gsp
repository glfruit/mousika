<%@ page import="com.sanwn.mousika.FileRepository" %>
<%@ taglib uri="http://ckfinder.com" prefix="ckfinder" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="course">
        <title>${course?.title}->课程资料</title>
    </head>

    <body>
        <div id="course-fileRepository" class="content scaffold-list"
             role="main">
            <h4 style="border-bottom: 1px solid black;">
                <a href="${createLink(controller: 'course', action: 'show', id: course?.id)}">${course?.title}</a>->课程资料
            </h4>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <ckfinder:ckfinder basePath="${resource(dir: '/ckfinder')}"/>
        </div>
    </body>
</html>
