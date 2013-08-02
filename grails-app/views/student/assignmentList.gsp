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
                <g:if test="${assignments}">
                    %{--<table width="100%">--}%
                        <g:set var="courseId" value="-1"></g:set>

                        <g:each in="${assignments}" status="i" var="assignment">
                            <g:if test="${courseId!=assignment.section.course.id}">
                                <g:if test="${i>0}">
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </section>
                                </g:if>

                                <g:set var="courseId" value="${assignment.section.course.id}"></g:set>
                                <section style="border: 1px solid #A0A0A0;padding-left: 0px;padding-right: 0px;margin-top:10px;margin-bottom: 10px;">
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td width="140" height="30" align="center" bgcolor="#929292" style="font-weight: bold">
                                                ${assignment.section.course.title}
                                            </td>
                                            <td width="10">&nbsp;</td>
                                            <td>
                                                <table width="96%" align="left">
                                                    <tr>
                                                        <td>
                                                            <g:link action="resource" params="['id':assignment.id]" >${assignment.title}</g:link>
                                                            <g:if test="${assignment.availableFrom<=new Date()&&new Date()<=assignment.dueDate}">
                                                                <a color="red">*</a>
                                                            </g:if>
                                                            %{--<g:link action="assignment" params="['assignmentId':assignment.id]">${assignment.title}</g:link>--}%
                                                        </td>
                            </g:if>
                            <g:else>
                                <td>
                                    <g:link action="resource" params="['id':assignment.id]">${assignment.title}</g:link>
                                    <g:if test="${assignment.availableFrom<=new Date()&&new Date()<=assignment.dueDate}">
                                        <a style="color:red;" title="最新作业">*</a>
                                    </g:if>
                                </td>
                            </g:else>
                        </g:each>
                        <g:if test="${assignments.size>0}">
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </section>
                        </g:if>
                    %{--</table>--}%
                </g:if>
                <g:else>
                    没有任何课程
                </g:else>
        </div>


    </body>
</html>
