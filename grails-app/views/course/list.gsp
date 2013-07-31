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
        <g:if test="${org.apache.shiro.SecurityUtils.subject.hasRoles([com.sanwn.mousika.Role.ADMIN])}">
            <h4 style="border-bottom: 1px solid #000;color: #777777;">
                <g:message code="label.course.list"/>
            </h4>
        </g:if>
        <g:else>
            <h4 style="border-bottom: 1px solid #000;color: #777777;">
                <g:message code="label.course.teacher"/>
            </h4>
        </g:else>
        <g:if test="${courseInstanceList}">
            <g:each in="${courseInstanceList}" status="i"
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

                            <p>教师：<g:link controller="user" action="show"
                                          id="${teachers[i]?.user?.id}">${teachers[i]?.user?.fullname}</g:link></p>
                        </li>
                        <li class="span6">
                            <g:set var="desc"
                                   value="${courseInstance.description}"/>
                            ${StringEscapeUtils.unescapeHtml(desc)}
                        </li>
                    </ul>
                </section>
            </g:each>
        </g:if>
        <g:else>
            <p>暂时没有任何课程</p>
        </g:else>
        <shiro:hasPermission permission="course:create">
            <g:link controller="course" action="create"
                    class="btn create"><g:message
                    code="course.create.label"/></g:link>
        </shiro:hasPermission>
        <g:form style="float: right;" class="form-search"
                url="[controller: 'course', action: 'search']" method='get'>
            <g:textField name="q" value="${params.q}" size="50"
                         class="input-medium search-query"/>
            <button type="submit" class="btn"><g:message
                    code="course.search.label"/></button>
        </g:form>
        <div style="clear:both;"></div>
    </body>
</html>
