<%@ page import="com.sanwn.mousika.Role; org.apache.commons.lang.StringEscapeUtils; com.sanwn.mousika.User; com.sanwn.mousika.Course" %>
<!DOCTYPE html>
<html>
    <head>
        <g:set var="entityName"
               value="${message(code: 'course.label')}"/>
        <title><g:message code="default.list.label"
                          args="[entityName]"/></title>
    </head>

    <body>
        <g:if test="${org.apache.shiro.SecurityUtils.subject.hasRoles([com.sanwn.mousika.Role.STUDENT])}">
            <h4 style="border-bottom: 1px solid #000;color: #777777;">
                <g:message code="label.student.working"/>
            </h4>
        </g:if>

        <div data-dojo-type="dijit/TitlePane"
             data-dojo-props="title: '我的作业'"
             style="padding-bottom: 10px;">
                <g:if test="${assignment}">
                    <table width="96%" border="0">
                        <tr>
                            <th width="90">
                                课程名称：
                            </th>
                            <td>
                                ${assignment.section.course.title}
                            </td>
                            <th width="90">
                                作业名称：
                            </th>
                            <td>
                                ${assignment.title}
                            </td>
                        </tr>
                        <tr>
                            <th>
                                作业内容：
                            </th>
                            <td colspan="3">
                                ${assignment.description}
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="center">
                                提交作业
                            </td>
                        </tr>
                    </table>
                </g:if>
                <g:else>
                    无该作业
                </g:else>
        </div>


    </body>
</html>
