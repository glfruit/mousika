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
            <g:message code="label.course.regCourse"/>
        </h4>
    </g:if>

    <g:if test="${notRegCoures}">
        <g:each in="${notRegCoures}" status="i"
                var="courseInstance">
            <section
                    style="border: 1px solid #A0A0A0;padding-left: 10px;padding-right: 10px;margin-top:10px;margin-bottom: 10px;">
                <ul class="thumbnails">
                    <li class="span5">
                        <h3>
                            <g:link action="show"
                                    id="${courseInstance.id}">
                                ${fieldValue(bean: courseInstance, field: "title")}
                            </g:link>
                        </h3>

                </ul>
            </section>
        </g:each>
        <p>
            <g:link controller="student" action="regCourse" class="btn create">注 册</g:link>
        <p>
    </g:if>
    <g:else>
        <p>暂时没有任何课程</p>
    </g:else>


</body>
</html>
