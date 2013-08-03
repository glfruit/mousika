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
                <g:if test="${assignments}">
                    <table width="100%">
                    <g:each in="${assignments}" status="i" var="assignment">
                        <g:if test="${i<3}">
                        <tr><td>
                            <g:link action="resource" params="['id':assignment.id]">${assignment.title}【${assignment.section.course.title}】</g:link>
                            %{--<g:link action="assignment" params="['assignmentId':assignment.id]">${assignment.title}【${assignment.section.course.title}】</g:link>--}%
                        </td></tr>
                        </g:if>
                    </g:each>
                    <g:if test="${assignments.size>3}">
                        <tr><td align="right">
                            <g:link action="assignmentList">&gt;&gt;more...</g:link>
                        </td></tr>
                    </g:if>
                    </table>
                </g:if>
                <g:else>
                    没有任何课程
                </g:else>
        </div>

        <div data-dojo-type="dijit/TitlePane"
             data-dojo-props="title: '我的提问与解答'"
             style="padding-bottom: 10px;">
            <p>
                作业1
            </p>
            <p>
                作业2
            </p>
        </div>

        <div data-dojo-type="dijit/TitlePane"
             data-dojo-props="title: '新闻讨论区'"
             style="padding-bottom: 10px;">
            <p>
                灌水区
            </p>
            <p>
                浅水区
            </p>
        </div>

    </body>
</html>
