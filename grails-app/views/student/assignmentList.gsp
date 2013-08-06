<%@ page import="com.sanwn.mousika.Role; org.apache.commons.lang.StringEscapeUtils; com.sanwn.mousika.User; com.sanwn.mousika.Course" %>
<!DOCTYPE html>
<html>
    <head>
        <g:set var="entityName"
               value="${message(code: 'course.label')}"/>
        <title><g:message code="default.list.label" args="[entityName]"/></title>
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
            <g:if test="${assignments!=null&&assignments.size()>0}">
                <table width="100%">
                    <g:each in="${assignments}" status="i" var="ca">
                        <tr>
                            <td width="140" height="28" align="left" style="font-weight: bold">
                                【${ca.getKey().title}】
                            </td>
                            <td><table width="100%"><tr>
                                <g:each in="${ca.getValue()}" var="assignment">
                                    <td>
                                        <g:link action="resource" params="['id':assignment.id]">${assignment.title}</g:link>
                                    </td>
                                </g:each>
                            </tr></table></td></tr>
                    </g:each>
                </table>
            </g:if>
            <g:else>
                没有任何作业
            </g:else>
        </div>


    </body>
</html>
