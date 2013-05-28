<%@ page import="com.sanwn.mousika.domain.User; com.sanwn.mousika.domain.Role; com.sanwn.mousika.domain.Course" %>

<!DOCTYPE html>
<html>
    <head>
        <g:set var="entityName"
               value="${message(code: 'course.label', default: 'Course')}"/>
        <title><g:message code="course.enrol.label"/></title>
        <style>
        .commands {
            white-space: nowrap;
            display: inline;
        }

        li {
            cursor: text;
        }
        </style>
    </head>

    <body>
        <h4 id="courseTitleHead"
            style="border-bottom: 1px solid #000;color: #777777;">
            课程成员
        </h4>
        <table class="table">
            <thead>
                <th>姓名</th>
                <th>电子邮件</th>
                <th>最后访问时间</th>
                <th>角色</th>
            </thead>
            <tbody id="userRows">
                <g:each in="${members}" var="member">
                    <tr>
                        <td>${member.fullname}</td>
                        <td>${member.profile?.email}</td>
                        <td><g:formatDate date="${member.profile?.lastAccessed}"
                                          format="yyyy-MM-dd HH:mm:ss"/></td>
                        <td>
                            <g:each in="${member.roles}" var="role">
                                ${role.name}<i class="icon-remove"></i>
                            </g:each>
                        </td>
                    </tr>
                </g:each>
                <tr colspan="4"><a class="btn"
                                   href="${createLink(action: 'show', id: courseId)}">返回到课程</a>
                </tr>
            </tbody>
        </table>
    </body>
</html>
