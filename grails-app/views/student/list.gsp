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
                <g:message code="label.course.list"/>
            </h4>
        </g:if>

        <div data-dojo-type="dijit/TitlePane"
             data-dojo-props="title: '注册新课程'"
             style="padding-bottom: 10px;">
            <p>

            </p>
            <p>
                作业2
            </p>
        </div>

    </body>
</html>
