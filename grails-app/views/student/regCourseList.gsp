<%@ page import="com.sanwn.mousika.Role; org.apache.commons.lang.StringEscapeUtils; com.sanwn.mousika.User; com.sanwn.mousika.Course" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="course"/>
        <g:set var="entityName"
               value="${message(code: 'course.label')}"/>
        <title><g:message code="default.list.label"
                          args="[entityName]"/></title>

        <style type="text/css">
        .dojoxGridCell {
            font-size: 12px;
        }

        h2 {
            margin-top: 0;
        }
        </style>

    </head>

    <body>
        <shiro:hasRole name="${com.sanwn.mousika.Role.STUDENT}">
            <h4 style="border-bottom: 1px solid #000;color: #777777;">
                <g:message code="label.student.regCourse"/>
            </h4>
        </shiro:hasRole>

        <div id="list-user" class="content scaffold-show" role="main">
            <g:link action="regCourse" class="btn pull-right">批量注册</g:link>
            <g:link action="create" class="btn pull-right">查询</g:link>
        </div>
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <table class="table">
            <thead>
                <tr>
                    <th>课程名称</th>
                    <th>课程代码</th>
                    <th>授课周数</th>
                    <th>课程描述</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <g:if test="${notRegCourses}">
                    <g:each in="${notRegCourses}" var="course">
                        <tr>
                            <td>${course.title}</td>
                            <td>${course.code}</td>
                            <td>${course.numberOfWeeks}</td>
                            <td><%=course.description%></td>
                            <td>
                                <g:link action="regCourse"
                                        params="['courseId': course.id]"
                                        class="btn pull-right">申请</g:link>
                            </td>
                        </tr>
                    </g:each>
                </g:if>
                <g:else>
                    <tr>
                        <td colspan="4">
                            暂时没有任何课程
                        </td>
                    </tr>
                </g:else>

            </tbody>
        </table>
    </div>

    </body>
</html>
