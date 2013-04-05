<%@ page import="org.apache.commons.lang.StringEscapeUtils; com.sanwn.mousika.domain.User; com.sanwn.mousika.domain.Course" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="dojo">
        <g:set var="entityName"
               value="${message(code: 'course.label', default: 'Course')}"/>
        <title><g:message code="default.list.label"
                          args="[entityName]"/></title>
    </head>

    <body>
        <h4 style="border-bottom: 1px solid #000;color: #777777;"><g:message
                code="label.course.list"/></h4>
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <g:each in="${courseInstanceList}" status="i"
                var="courseInstance">
            <section
                    style="border: 1px solid #777777;padding-left: 10px;padding-right: 10px;">
                <ul class="thumbnails">
                    <li class="span5">
                        <h3>
                            <g:link action="show"
                                    id="${courseInstance.id}">
                                ${fieldValue(bean: courseInstance, field: "title")}
                            </g:link>
                        </h3>

                        <p>教师：${teachers[i].user.fullname}</p>
                    </li>
                    <li class="span6">
                        <g:set var="desc"
                               value="${courseInstance.description}"/>
                        ${StringEscapeUtils.unescapeHtml(desc)}
                    </li>
                </ul>
            </section>
        </g:each>
    </body>
</html>
