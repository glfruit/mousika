<%@ page import="com.sanwn.mousika.Role; org.apache.commons.lang.StringEscapeUtils; com.sanwn.mousika.User; com.sanwn.mousika.Course; com.sanwn.mousika.Assignment" %>
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
                <g:if test="${myCourses}">
                    <table width="100%">
                    <g:each in="${myCourses}" status="i" var="myCourse">
                        <g:if test="${myCourse.units}">
                            <g:each in="${myCourse.units}" status="j" var="unit">
                                <g:each in="${unit.items}" status="k" var="item">
                                    <g:if test="${item.content instanceof Assignment}">
                                        <tr><td>${item.content.title}【${myCourse.title}】${item.content.availableFrom}</td></tr>
                                    </g:if>
                                </g:each>
                            </g:each>
                        </g:if>
                    </g:each>
                            </table>
                </g:if>

                <g:if test="${assignments}">
                    <table width="100%">
                    <g:each in="${assignments}" status="i" var="assignment">
                        <g:if test="${assignment.availableFrom<=new Date()&&new Date()<=assignment.dueDate}">
                        <tr><td>
                            <g:link action="resource" params="['id':assignment.id]">${assignment.title}【${assignment.section.course.title}】</g:link>
                            %{--<g:link action="assignment" params="['assignmentId':assignment.id]">${assignment.title}【${assignment.section.course.title}】</g:link>--}%
                        </td></tr>
                        </g:if>
                    </g:each>
                    %{--<g:if test="${assignments.size>3}">--}%
                        <tr><td align="right">
                            <g:link action="assignmentList">查看全部&gt;&gt;</g:link>
                        </td></tr>
                    %{--</g:if>--}%
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
